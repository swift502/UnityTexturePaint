using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TexPaintLayer : MonoBehaviour
{
    public bool locked = false;
    public Text text;
    public Image textureIcon;
    public Image background;

    [HideInInspector]
    public TexturePaintManager managerInstance;
    [HideInInspector]
    public Texture2D mask;
    [HideInInspector]
    public TexPaintTexture assignedTexture;

    public void SetTexture(TexPaintTexture texture)
    {
        managerInstance.SetPaintTexture(GetLayerIndex(), texture.texture2D);
        textureIcon.sprite = texture.sprite;
        assignedTexture = texture;
    }

    public int GetLayerIndex()
    {
        return transform.GetSiblingIndex();
    }

    public void Select()
    {
        if(managerInstance.activeLayer != null) managerInstance.activeLayer.SetHighlighted(false);
        managerInstance.activeLayer = this;
        SetHighlighted(true);
        if (assignedTexture != null) assignedTexture.Select();
    }

    public void SetHighlighted(bool highlighted)
    {
        if(highlighted) background.color = Color.yellow;
        else background.color = Color.white;
    }

    public void SetName(string name)
    {
        text.text = name;
    }
}
