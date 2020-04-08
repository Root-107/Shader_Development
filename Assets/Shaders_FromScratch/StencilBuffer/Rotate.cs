using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class Rotate : MonoBehaviour
{
    [SerializeField]
    Vector3 rotateTo = new Vector3(0,0,0);
    // Update is called once per frame

    private void Start()
    {
        transform.DORotate(rotateTo, 10, RotateMode.LocalAxisAdd).SetLoops(-1, LoopType.Restart).SetEase(Ease.Linear);
    }
}
