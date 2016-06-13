using UnityEngine;
using System.Collections;

public class ViewSelector : MonoBehaviour 
{
    private Material _1sMat;
    private Material _2sMat;
    private Material _2pMat;

    private Light _1sLight;
    private Light _2sLight;


    const float X = 1.0f;
    const float O = 0.2f;


	void Start () 
    {
        _1sMat = Resources.Load("materials/1s", typeof(Material)) as Material;
        _2sMat = Resources.Load("materials/2s", typeof(Material)) as Material;
        _2pMat = Resources.Load("materials/2p", typeof(Material)) as Material;

        _1sLight = transform.GetChild(1).gameObject.GetComponent<Light>();
        _2sLight = transform.GetChild(2).gameObject.GetComponent<Light>();

        do_all();
	}
   
    private void _do(float s1, float s2, float p2)
    {
        var c1 = _1sMat.color;
        var c2 = _2sMat.color;
        var c3 = _2pMat.color;

        c1.a = s1; _1sMat.SetColor("_Color",c1);
        c2.a = s2; _2sMat.SetColor("_Color",c2);
        c3.a = p2; _2pMat.SetColor("_Color",c3);

        _1sLight.intensity = s1 * 2.0f;
        _2sLight.intensity = s2 * 2.0f;

    }

    public void do_all()     {_do(X, X, X);}
    public void do_nucleus() {_do(O, O, O);}
    public void do_1s()      {_do(X, O, O);} 
    public void do_2s()      {_do(O, X, O);}
    public void do_2p()      {_do(O, O, X);}


}
