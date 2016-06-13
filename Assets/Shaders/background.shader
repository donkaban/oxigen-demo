Shader "oxigen/background" {
Properties 
	{
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader {
	Pass 
	{
			GLSLPROGRAM

			uniform vec4      _Color;
			uniform vec4      _Time;  

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
	    void main()
	    {

   			gl_FragColor = _Color;
    	}

		#endif 
		ENDGLSL 
	}}}