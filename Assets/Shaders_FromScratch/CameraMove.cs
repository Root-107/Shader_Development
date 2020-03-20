using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class CameraMove : MonoBehaviour
{

    [SerializeField]
    GameObject pointA;

    [SerializeField]
    GameObject pointB;

    void Start()
    {
        if (pointA && pointB) 
        {
            Animate(pointA.transform.position, pointB.transform.position);
        }
    }

    void Animate(Vector3 start, Vector3 end) 
    {
        float distance = Vector3.Distance(start, end);
        transform.position = start;
        transform.DOMove(end, distance).SetEase(Ease.Linear).SetLoops(-1);
    }

}
