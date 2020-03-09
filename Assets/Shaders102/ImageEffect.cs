using UnityEngine;
[ExecuteInEditMode]
public class ImageEffect : MonoBehaviour {

	public bool rednerCam = false;
	public Material EffectMaterial;
	void OnRenderImage(RenderTexture src, RenderTexture dst){
		if(rednerCam)
		Graphics.Blit(src, dst, EffectMaterial);
	}

}
