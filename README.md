# UnityTexturePaint

Unity demo showcasing the ability to paint various textures on an object using up to 32 independent layers. Layers can be dynamically reordered. Performance scales dynamically with the number of used layers. Texture blending is done via brute force texture lerping within the shader. Shader variants were generated using the [ShaderGenerator.py](Texture%20paint%20test/Assets/Shaders/ShaderGenerator.py) python script.
