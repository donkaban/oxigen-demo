Shader "oxigen/background" {
Properties 
	{
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader {
	Pass 
	{
			GLSLPROGRAM

			uniform sampler2D _Texture;
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
	    
		float size = 32.0;
		float speed= 0.9;

		float random(vec2 co) { return fract(sin(dot(co.xy ,vec2(0.5, 8))) * 128.0);}

		vec3 random_color(vec2 coords)
		{
			float r = random(coords.xy * 32.0);
			float g = random(coords.xy * 64.0);
			float b = random(coords.xy * 128.0);
			return vec3(r,g,b);
		}
		float tri(float x)
		{
			x = mod(x,1.0);
			if (x > 1.0) x = -x+2.0;
			return x;
		}
		float chess_dist(vec2 uv) {return max(abs(uv.x),abs(uv.y));}

		void main( void ) 
		{
			vec3 colors = random_color(floor(uv*size))*step(chess_dist((fract(uv*size)-.5)*2.),tri((((_Time.y*speed)+((random(floor(uv*size)))*2.)))));
			gl_FragColor = vec4(colors, 1.0 );
		}

		#endif 
		ENDGLSL 
	}}}