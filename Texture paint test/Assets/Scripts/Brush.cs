using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Brush : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 mouseToWorld = Camera.main.ScreenToWorldPoint(Input.mousePosition);
        transform.position = new Vector3(mouseToWorld.x, 1, mouseToWorld.z);
    }
}
