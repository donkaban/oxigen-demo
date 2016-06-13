Shader "oxigen/shell" 
{
	Properties 
	{
		_Color("Color", Color) = (1,1,1,1)
		_Treshold("Treshold", Range (.5,1.0)) = 0.98
		_Speed("Speed", Range (0,1.0)) = 0.2
	}

	SubShader {
	Tags { "Queue" = "Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }

	Pass 
	{
		Blend SrcAlpha OneMinusSrcAlpha
		Lighting Off
		ZWrite Off
        Cull off

		GLSLPROGRAM

			uniform vec4   _Color;
			uniform vec4   _Time; 
			uniform float  _Treshold; 
			uniform float  _Speed;


	    #ifdef VERTEX 

	   		varying vec2 uv; 
	        void main() 
	        {
	        	uv = gl_MultiTexCoord0.xy;
	         	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	       	}

	    #endif
	    #ifdef FRAGMENT
	
			varying vec2 uv; 
		
			float rnd(vec3 a) {return fract(a.z + sin(a.x*a.y*1424.0) * 12345.2);} 
			void main() 
			{
				float col = rnd(vec3(uv,cos(_Time.y * _Speed))) ; 
				gl_FragColor = (col > _Treshold ) ? _Color * col : vec4(0,0,0,0);
			}

		#endif 
		ENDGLSL 
	}



	}}
