using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RocketSpawn : MonoBehaviour {

	public GameObject RocketPrefab;
	public GameObject RocketExplode;

	void Start()
	{
		StartCoroutine(spawnRocket());
	}

	IEnumerator spawnRocket(){
		yield return new WaitForSeconds(3);
		Instantiate(RocketPrefab, transform.position, transform.rotation);
		StartCoroutine(spawnRocket());
	}
}
