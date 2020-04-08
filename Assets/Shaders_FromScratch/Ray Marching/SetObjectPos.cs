using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetObjectPos : MonoBehaviour
{
    [SerializeField]
    Material mat;

    // Update is called once per frame
    void Update()
    {
        if (mat != null) 
        {
            mat.SetVector("_ObjectPos", new Vector4(transform.position.x, transform.position.y, transform.position.z, 0));
        }
    }
}
