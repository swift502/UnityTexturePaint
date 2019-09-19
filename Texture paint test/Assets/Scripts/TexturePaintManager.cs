using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class TexturePaintManager : MonoBehaviour
{
    public SO_TextureLibrary textureLibrary;
    public TexPaintLayer layerPrefab;
    public TexPaintTexture texturePrefab;

    public GridLayoutGroup textureList;
    public VerticalLayoutGroup layersList;

    //[HideInInspector]
    //public List<TexPaintLayer> layers;
    //[HideInInspector]
    //public List<TexPaintTexture> textures;

    [HideInInspector]
    public TexPaintLayer activeLayer;
    [HideInInspector]
    public TexPaintTexture activeTexture;

    [HideInInspector]
    public Material groundMaterial;

    int counter = 0;

    void Start()
    {
        // Get material instance
        groundMaterial = GameObject.Find("GroundPlane").GetComponent<Renderer>().material;

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
    }

    public void AddLayer()
    {
        AddLayer("Layer" + (++counter), false);
    }

    public void AddLayer(string name, bool locked = false)
    {
        TexPaintLayer layer = Instantiate(layerPrefab, layersList.transform);
        layer.managerInstance = this;
        layer.locked = locked;
        layer.SetTexture(activeTexture);
        layer.SetName(name);
        layer.Select();
    }

    public void RemoveActiveLayer()
    {
        if (activeLayer.locked) return;

        int newIndex = activeLayer.transform.GetSiblingIndex() - 1;
        Destroy(activeLayer.gameObject);
        layersList.transform.GetChild(newIndex).GetComponent<TexPaintLayer>().Select();
    }

    public void ShiftLayer(TexPaintLayer layer, int shiftAmount)
    {
        if (layer.locked) return;

        int oldIndex = layer.transform.GetSiblingIndex();
        int newIndex = oldIndex + shiftAmount;

        if (newIndex >= 0 && newIndex < layersList.transform.childCount)
        {
            TexPaintLayer otherLayer = layersList.transform.GetChild(newIndex).GetComponent<TexPaintLayer>();
            if (otherLayer.locked) return;

            // Move
            layer.transform.SetSiblingIndex(newIndex);

            // Update terrain material
            SetPaintTexture(newIndex, layer.assignedTexture.texture2D);
            SetPaintMask(newIndex, layer.mask);

            SetPaintTexture(oldIndex, otherLayer.assignedTexture.texture2D);
            SetPaintMask(oldIndex, otherLayer.mask);
        }
    }

    public void MoveActiveLayerUp()
    {
        ShiftLayer(activeLayer, -1);
    }

    public void MoveActiveLayerDown()
    {
        ShiftLayer(activeLayer, +1);
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
