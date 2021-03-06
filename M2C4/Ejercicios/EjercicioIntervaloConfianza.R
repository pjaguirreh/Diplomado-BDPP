######################
## Cargar librerías ##
######################
library(readxl) # Cargar datos
library(dplyr) # Manejo de datos
library(stringr) # Manejo de texto
library(ggplot2) # Visualización de datos

##################
## Cargar datos ##
##################
censo <- read_csv("../datos/muestra_censo_2017.csv")

################
## Ejercicios ##
################

## Donde vea "***" es donde debe escribir algo

# Calcule el % de personas en la poblacion que declaran ser parte 
# de pueblos originarios
*** %>% 
  group_by(***) %>% 
  ***(n = n()) %>% 
  mutate(prop = n/***(n))

# Tome una muestra aleatoria de 300 (n) observaciones desde la poblacion
# y solo deje la columna correspondiente a "p_originario"
# Llame a este nuevo objeto "muestra_censo_ej"
set.seed(1) # para tener los mismos resultados
(muestra_censo_ej <- censo %>% 
    sample_n(***) %>% 
    ***(p_originario))

# Calcule el % de personas en la muestra que declaran ser parte 
# de pueblos originarios
muestra_censo_ej %>% 
  ***(***) %>% 
  ***(n = n()) %>% 
  ***(prop = n/***(n))

# Haga lo mismo usando las funciones del paquete "infer".
# Llame a este objeto "prop_p_orig_muestra"
(prop_p_orig_muestra <- muestra_censo_ej %>% 
    specify(response = ***, success = "si") %>% 
    calculate(stat = "prop"))

# Usando las funciones del paquete "infer" saque 1000 remuestras usando "bootstrap"
# Y calcule para cada muestra el % de personas que declaran ser parte de un 
# pueblo originario. Llame a este objeto "remuestras_p_orig".
(remuestras_p_orig <- muestra_censo_ej %>% 
    ***(response = ***, success = "si") %>% 
    generate(reps = ***, 
             type = ***) %>% 
    calculate(stat = "prop"))

# Grafique la distribución (histograma) de los 1000 % calculados a partir de 
# las remuestras. Haga el histograma con 15 barras y con lineas colo blanco.
remuestras_p_orig %>% 
  ggplot(aes(x = ***)) +
  geom_***(bins = ***, color = ***)

# Compare el gráfico recién hecho con el resultante usando la función 
# "visualise()" del paquete "infer".
remuestras_p_orig %>% 
  ***()

# Calcule el intervalo de confianza usando los métodos de percentiles y error estándar
# ¿Son similares los I.C.? ¿Contienen los I.C. el valor real del % de personas
# que en la población declaran ser parte de prueblos originales?
remuestras_p_orig %>% 
  get_confidence_interval(level = 0.95,
                          type = ***)

remuestras_p_orig %>% 
  get_confidence_interval(level = 0.95,
                          type = ***,
                          point_estimate = prop_p_orig_muestra)

# Vuelva al objeto "prop_p_orig_muestra". Recuerde que este representa la proporción
# de personas que se identifican parte de pueblos originarios en la única muestra
# tomada de 300 personas. Use este valor para calcular un intervalo de confianza
# con un 95% nivel de confianza. 
# ¿Es este I.C. similar a los calculados a partir de las remuestras?"
prop_p_orig_muestra %>% 
  rename(p_hat = stat) %>% 
  mutate(
    ee = sqrt((p_hat*(1-p_hat))/300),
    IC_1 = *** - (1.96* ***),
    IC_2 = *** + (1.96* ***)
  )