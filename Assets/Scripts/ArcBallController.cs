using UnityEngine;
using System.Collections;

public class ArcBallController : MonoBehaviour 
{

    public float damping = 0.999f;
    public float speed = 5f;

    private Vector3 vDown;
    private Vector3 vDrag;
    private bool dragging = false;
    private float angularVelocity;
    private Vector3 rotationAxis;

    void Start()
    {
        angularVelocity = 0;
        rotationAxis = Vector3.zero;
    }

    void Update()
    {   
        if(Input.GetMouseButton(0)) 
        {
            var ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if(Physics.Raycast(ray, out hit)) 
            {
                if(!dragging )
                {
                    vDown = hit.point - transform.position;
                    dragging = true;
                }
                else
                {
                    vDrag = hit.point - transform.position;

                    rotationAxis = Vector3.Cross( vDown, vDrag );
                    angularVelocity = Vector3.Angle(vDown, vDrag) * speed;
                }
            }
            else
                dragging = false;
        }

        if( Input.GetMouseButtonUp(0) )
            dragging = false;

        if( angularVelocity > 0 )
        {
            transform.RotateAround(transform.position, rotationAxis, angularVelocity * Time.deltaTime );
            angularVelocity = (angularVelocity > 0.01f) ? angularVelocity * damping : 0;
        }
    }
}
