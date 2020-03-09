using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ReplaceShanderEffect : MonoBehaviour {
	public Shader ReplaceShader;
	void OnEnable()
	{
		if(ReplaceShader != null){
			GetComponent<Camera>().SetReplacementShader(ReplaceShader, "RenderType");
		}
	}

	void OnDisable()
	{
		GetComponent<Camera>().ResetReplacementShader();
	}
	
}
