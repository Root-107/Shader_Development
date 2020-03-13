using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroySelf : MonoBehaviour {

	// Use this for initialization
	void Start () {
		StartCoroutine(Destroy());
	}
	
	// Update is called once per frame
	IEnumerator Destroy(){
		yield return new WaitForSeconds(2.5f);
		Destroy(gameObject);
	}
}
