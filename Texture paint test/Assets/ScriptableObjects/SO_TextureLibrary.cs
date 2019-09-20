using System;
using UnityEngine;

[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/SO_TextureLibrary", order = 1)]
public class SO_TextureLibrary : ScriptableObject
{
    public TextureLibraryItem[] textures;
}

[Serializable]
public class TextureLibraryItem
{
    public Texture2D texture2D;
    public Sprite sprite;
}
