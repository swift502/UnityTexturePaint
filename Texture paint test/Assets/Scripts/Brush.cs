using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Brush : MonoBehaviour
{
    void Update()
    {
        // Move brush to cursor
        Vector3 mouseToWorld = Camera.main.ScreenToWorldPoint(Input.mousePosition);
        transform.position = new Vector3(mouseToWorld.x, 0.1f, mouseToWorld.z);
    }
}
