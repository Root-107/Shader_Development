using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EdenElement : MonoBehaviour
{
    public App app {get {return GameObject.FindObjectOfType<App>();}} 
}

public class App : MonoBehaviour {
    public EdenController _controller;
    public EdenModle _modle;
}


