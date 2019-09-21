using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TexturePaintManager : MonoBehaviour
{
    //Public
    public SO_TextureLibrary textureLibrary;

    public TexPaintLayer layerPrefab;
    public TexPaintTexture texturePrefab;

    public GridLayoutGroup textureList;
    public VerticalLayoutGroup layersList;

    [HideInInspector]
    public TexPaintLayer activeLayer;
    [HideInInspector]
    public TexPaintTexture activeTexture;

    // Private
    private GameObject groundObject;
    private Material groundMaterial;

    private bool paintingAdd = false;
    private bool paintingSubstract = false;
    private Vector3 lastMouse;

    void Start()
    {
        // Get material instance
        groundObject = GameObject.Find("GroundPlane");
        groundMaterial = groundObject.GetComponent<Renderer>().material;

        // Initialize textures
        foreach (TextureLibraryItem item in textureLibrary.textures)
        {
            TexPaintTexture texture = Instantiate(texturePrefab, textureList.transform);
            texture.texture2D = item.texture2D;
            texture.sprite = item.sprite;
            texture.textureIcon.sprite = item.sprite;
            texture.managerInstance = this;
        }
        textureList.transform.GetChild(0).GetComponent<TexPaintTexture>().Select();

        // Initialize base layer
        AddLayer("Base layer", true);
        RefreshTerrainShader();
    }

    void Update()
    {
        // Bind mouse events
        if (Input.GetMouseButtonDown(0))
        {
            paintingAdd = true;
            lastMouse = Input.mousePosition;
        }
        if (Input.GetMouseButtonUp(0)) paintingAdd = false;
        if (Input.GetMouseButtonDown(1))
        {
            paintingSubstract = true;
            lastMouse = Input.mousePosition;
        }
        if (Input.GetMouseButtonUp(1)) paintingSubstract = false;

        // Painting
        if ((paintingAdd || paintingSubstract) && !(paintingAdd && paintingSubstract))
        {
            Vector3 currentMouse = Input.mousePosition;
            Vector3 mouseDelta = currentMouse - lastMouse;

            // Fill in large mouse movement gaps
            for(float t = 0f; t < 1f; t += 0.025f / (mouseDelta.magnitude / Screen.width))
            {
                Paint(Vector3.Lerp(lastMouse, currentMouse, t));
            }

            lastMouse = currentMouse;
        }
    }

    public void AddLayer()
    {
        AddLayer("Layer" + (GetNumberOfLayers() + 1), false);
    }

    public void AddLayer(string name, bool locked = false)
    {
        if (GetNumberOfLayers() >= 32) return;

        TexPaintLayer layer = Instantiate(layerPrefab, layersList.transform);
        layer.managerInstance = this;
        layer.locked = locked;
        layer.mask = new Texture2D(128, 128);
        layer.mask.SetPixels(new Color[128 * 128]);
        layer.SetTexture(activeTexture);
        layer.SetName(name);
        layer.Select();

        RefreshTerrainShader();
        int index = layer.transform.GetSiblingIndex();
        SetPaintTexture(index, layer.assignedTexture.texture2D);
        SetPaintMask(index, layer.mask);
    }

    public void RemoveActiveLayer()
    {
        if (activeLayer.locked) return;

        int newIndex = activeLayer.transform.GetSiblingIndex() - 1;
        DestroyImmediate(activeLayer.gameObject);
        layersList.transform.GetChild(newIndex).GetComponent<TexPaintLayer>().Select();

        RefreshTerrainShader();
    }

    public void MoveActiveLayerUp()
    {
        ShiftLayer(activeLayer, -1);
    }

    public void MoveActiveLayerDown()
    {
        ShiftLayer(activeLayer, +1);
    }

    // Currently shiftAmount needs to be 1 or -1
    // Larger / smaller values won't work properly
    public void ShiftLayer(TexPaintLayer layer, int shiftAmount)
    {
        if (layer.locked) return;

        int oldIndex = layer.transform.GetSiblingIndex();
        int newIndex = oldIndex + shiftAmount;

        if (newIndex >= 0 && newIndex < layersList.transform.childCount)
        {
            TexPaintLayer otherLayer = layersList.transform.GetChild(newIndex).GetComponent<TexPaintLayer>();
            if (otherLayer.locked) return;

            // Move the layer
            layer.transform.SetSiblingIndex(newIndex);

            // Update terrain material
            SetPaintTexture(newIndex, layer.assignedTexture.texture2D);
            SetPaintMask(newIndex, layer.mask);

            SetPaintTexture(oldIndex, otherLayer.assignedTexture.texture2D);
            SetPaintMask(oldIndex, otherLayer.mask);
        }
    }

    // This function is very rudimentary
    // FlowScape already has a much better painting system
    private void Paint(Vector3 mousePosition)
    {
        Vector3 mouseWorld = Camera.main.ScreenToWorldPoint(mousePosition);
        Bounds bounds = groundObject.GetComponent<Renderer>().bounds;
        Vector2 mouse01 = new Vector2(
            (mouseWorld.x - bounds.min.x) / (bounds.max.x - bounds.min.x),
            (mouseWorld.z - bounds.min.z) / (bounds.max.z - bounds.min.z)
        );

        float brushRadius = 0.15f;
        Color[] paintArray = activeLayer.mask.GetPixels();
        for (int i = 0; i < paintArray.Length; i++)
        {
            Vector2 pixel = new Vector2(1 - (i % 128) / 128f, 1 - (i / 128) / 128f);
            float grayscale = Mathf.Min((brushRadius - Mathf.Min(Vector2.Distance(mouse01, pixel), brushRadius)) * (1 / brushRadius) * 1.3f, 1f);
            if(paintingAdd)
            {
                paintArray[i] = MaxColor(paintArray[i], ColorFromGrayscale(grayscale));
            }
            if(paintingSubstract)
            {
                paintArray[i] = MinColor(paintArray[i], ColorFromGrayscale(1-grayscale));
            }
        }
        activeLayer.mask.SetPixels(paintArray);
        activeLayer.mask.Apply();
    }

    private int GetNumberOfLayers()
    {
        return layersList.transform.childCount;
    }

    private void RefreshTerrainShader()
    {
        // Select the most optimal shader for the number of layers we currently have
        // AFAIK this is necessary unless we want to compile shaders on the fly
        groundMaterial.shader = Shader.Find("Custom/" + GetNumberOfLayers() + "Layers");
    }

    private Color ColorFromGrayscale(float grayscale)
    {
        return new Color(grayscale, grayscale, grayscale);
    }

    private Color MinColor(Color color1, Color color2)
    {
        return new Color(
            Mathf.Min(color1.r, color2.r),
            Mathf.Min(color1.g, color2.g),
            Mathf.Min(color1.b, color2.b)
        );
    }

    private Color MaxColor(Color color1, Color color2)
    {
        return new Color(
            Mathf.Max(color1.r, color2.r),
            Mathf.Max(color1.g, color2.g),
            Mathf.Max(color1.b, color2.b)
        );
    }

    public void SetPaintTexture(int layerIndex, Texture2D texture)
    {
        groundMaterial.SetTexture("_Texture" + layerIndex, texture);
    }

    public void SetPaintMask(int layerIndex, Texture2D mask)
    {
        groundMaterial.SetTexture("_Mask" + layerIndex, mask);
    }
}
