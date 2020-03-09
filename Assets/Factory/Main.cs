using System.Collections;
using System.Collections.Generic;
using UnityEngine;

class Main
{
    [RuntimeInitializeOnLoadMethod]
    static void OnRuntimeMethodLoad()
    {
        Debug.Log("Loaded Scene");
    }
	static GameObject AppInstance = null;
	[RuntimeInitializeOnLoadMethod]
    static void OnSecondRuntimeMethodLoad()
    {
		AppInstance = new GameObject("AppInstance");
		AppInstance.AddComponent<App>();
		AppInstance.AddComponent<EdenController>();
		AppInstance.AddComponent<EdenModle>();
		AppInstance.GetComponent<App>()._controller = AppInstance.GetComponent<EdenController>();
		AppInstance.GetComponent<App>()._modle = AppInstance.GetComponent<EdenModle>();
    }

}
