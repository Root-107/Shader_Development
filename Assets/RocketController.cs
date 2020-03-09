using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RocketController : MonoBehaviour {
	
	// Update is called once per frame
	public float speedMultiplyer = 40;
	public GameObject PSystem;
	void Start()
	{
		StartCoroutine(DestroyTimeOut());
	}
	void Update () {
		transform.position += Vector3.forward * Time.deltaTime * speedMultiplyer;
	}

	void OnTriggerEnter(Collider e)
	{
		Instantiate(PSystem, transform.position, transform.rotation);
		Destroy(gameObject);
	}

	IEnumerator DestroyTimeOut(){
		yield return new WaitForSeconds(5);
		Destroy(gameObject);
	}

}
