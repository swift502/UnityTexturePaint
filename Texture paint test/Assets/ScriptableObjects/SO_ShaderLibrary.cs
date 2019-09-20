using System;
using UnityEngine;

[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/SO_ShaderLibrary", order = 1)]
public class SO_ShaderLibrary : ScriptableObject
{
    public Shader[] shaders;
}
