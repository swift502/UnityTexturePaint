using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TexPaintTexture : MonoBehaviour
{
    public Image background;
    public Image textureIcon;

    [HideInInspector]
    public TexturePaintManager managerInstance;
    [HideInInspector]
    public Texture2D texture2D;
    [HideInInspector]
    public Sprite sprite;

    public void Select()
    {
        if (managerInstance.activeTexture != null) managerInstance.activeTexture.SetHighlighted(false);
        managerInstance.activeTexture = this;
        SetHighlighted(true);
        if (managerInstance.activeLayer != null) managerInstance.activeLayer.SetTexture(this);
    }

    public void SetHighlighted(bool highlighted)
    {
        if (highlighted) background.color = Color.yellow;
        else background.color = Color.white;
    }
}
