#%%
!pip install pandas
!pip install scikit-learn
!pip install matplotlib
!pip install seaborn
#%%
!pip install ucimlrepo
#%%
from ucimlrepo import fetch_ucirepo

# fetch dataset
estimation_of_obesity_levels_based_on_eating_habits_and_physical_condition = fetch_ucirepo(id=544)

# data (as pandas dataframes)
X = estimation_of_obesity_levels_based_on_eating_habits_and_physical_condition.data.features
y = estimation_of_obesity_levels_based_on_eating_habits_and_physical_condition.data.targets

# metadata
print(estimation_of_obesity_levels_based_on_eating_habits_and_physical_condition.metadata)

# variable information
print(estimation_of_obesity_levels_based_on_eating_habits_and_physical_condition.variables)

#%%
import matplotlib.pyplot as plt
from sklearn.preprocessing import MinMaxScaler
import seaborn as sns
import pandas as pd
#%%
dataSet= pd.read_csv("ObesityDataSet_raw_and_data_sinthetic.csv")
#%%
dataSet.head()
#%%
dataSet.info()
#%%
dataSet.shape

#%%
categoricas = dataSet.select_dtypes(exclude=['number']).copy()
numericas = dataSet.select_dtypes(include=['number']).copy()
numericas.head()
#%%
for i in numericas.columns:
    plt.hist(numericas[i], bins=20, color='skyblue', edgecolor='black')
    plt.xlabel(i)
    plt.ylabel('Frequency')
    plt.title(f'Distribution of {i}')
    plt.show()

#%%
for i in categoricas.columns:
    unique_values = categoricas[i].value_counts()
    plt.bar(unique_values.index.astype(str), unique_values.values, color='orange', edgecolor='black')
    plt.xlabel(i)
    plt.ylabel('Frequency')
    plt.title(f'Distribution of {i}')
    plt.xticks(rotation=45, ha='right')
    plt.tight_layout()
    plt.show()
#%%
columnas = numericas.columns

for i in range(len(columnas)):
    for j in range(i + 1, len(columnas)):  # Evita pares repetidos e iguales (como i==j)
        x = columnas[i]
        y = columnas[j]
        plt.scatter(numericas[x], numericas[y], alpha=0.6)
        plt.xlabel(x)
        plt.ylabel(y)
        plt.title(f'{x} vs {y}')
        plt.tight_layout()
        plt.show()
#%%
# Calcular la matriz de correlación
correlation_matrix = numericas.corr()

# Dibujar el heatmap
plt.figure(figsize=(10, 8))
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', fmt=".2f", square=True)
plt.title('Correlation Matrix of Numerical Variables')
plt.tight_layout()
plt.show()
#%% md
# 
# **Limpieza de Datos**
# 
# 1.  Técnicas de selección (Registros)
# 
#   Seleccionamos todos los registros del dataset, ya que no existen valores atípicos evidentes ni datos faltantes relevantes. Todos los ejemplos aportan información útil para el entrenamiento del modelo de clasificación de niveles de obesidad.
# 2.  Técnicas de selección (Atributos)
# 
#   Columna NObeyesdad, que representa el nivel de obesidad, es la variable objetivo. Por lo tanto, se separa del conjunto de atributos de entrada, ya que no debe influir en el entrenamiento directo como predictor, sino que es el valor que el modelo intentará predecir y luego validar.
# 
# 
# 
# 
#%% md
# 3. Datos Incompletos
# 
#   En el código a continuación podemos observar "0" en cada columna indica que no hay valores nulos o faltantes para esa columna. Es decir, todas las columnas tienen el mismo número de registros en total, es decir sin registros perdidos.
# 
#   El dataset no tiene datos faltantes, lo cual es positivo porque no tendrás que hacer tratamiento de datos faltantes. Esto facilita el análisis y la modelización posterior.
#%%
# Verificar si hay datos faltantes
missing_data = dataSet.isnull().sum()
missing_data_percentage = (missing_data / len(dataSet)) * 100

# Mostrar la información de los datos faltantes
print("Datos faltantes por columna:")
print(missing_data)
print("\nPorcentaje de datos faltantes por columna:")
print(missing_data_percentage)

#%% md
# 4. Datos Redundantes
# 
#   Hay datos redundantes, debido a que hay 24 filas duplicada.
#   
# 
#%%
dataSet.duplicated().sum()
#%%
duplicated_rows = dataSet[dataSet.duplicated()]
print(duplicated_rows)

#%%
dataSet = dataSet.drop_duplicates()

#%%
dataSet.duplicated().sum()

#%% md
# 5. Datos Inconsistentes
# 
#   No hemos encontrado datos inconsistentes porque cuando hacemos las comprobaciones mediante código no nos salen ni números raros ni palabras raras. Como por ejemplo en altura que alguien mida 5 metros o que haya un genero que sea otra cosa distinta a Female y Male. Es decir no hay datos incosistentes
#   
# 
#%%
# Filtrar valores inconsistentes
print("\nAlturas menores a 1.0 metro o mayores a 2.5 metros:")
print(dataSet[(dataSet['Height'] < 1.0) | (dataSet['Height'] > 2.5)])

print("\nEdades menores a 5 o mayores a 100:")
print(dataSet[(dataSet['Age'] < 5) | (dataSet['Age'] > 100)])

print("\nPesos menores a 30kg o mayores a 200kg:")
print(dataSet[(dataSet['Weight'] < 30) | (dataSet['Weight'] > 200)])

print("\nValores inusuales en FCVC (esperado: entre 1.0 y 3.0):")
print(dataSet[(dataSet['FCVC'] < 1.0) | (dataSet['FCVC'] > 3.0)])

print("\nValores inusuales en NCP (esperado: entre 1 y 5):")
print(dataSet[(dataSet['NCP'] < 1) | (dataSet['NCP'] > 5)])

#%%
# Revisar valores únicos por columna categórica
categoricas = dataSet.select_dtypes(exclude=['number'])
for col in categoricas.columns:
    print(f"\nValores únicos en '{col}':")
    print(dataSet[col].unique())

#%% md
# 6. Errores de Transcripción
# 
# 
# 
# 7. Variaciones en las referencias a los mismo conceptos
# 
# 
# 8. Valores atípicos
# 
# 
#%% md
# ** Transformación de Datos**
# 
# Solo vamos a hacer la transformación de datos categóricos a numéricos.
# 
# 1. Datos categóricos a numéricos
#%%
from sklearn.model_selection import train_test_split

X = dataSet.drop(columns=['NObeyesdad'])
Y = dataSet['NObeyesdad']
#%%
X = pd.get_dummies(X, dtype = int)
X.head ()
#%% md
# **Normalización de datos**
# 
# 
#%%
scaler = MinMaxScaler()
datos_normalizados = scaler.fit_transform(X)
datos_normalizados
#%%
dataSet.to_csv('datos_normalizados.csv', index=False)
#%%
dt = pd.read_csv('datos_normalizados.csv')
dt.head()
#%%

X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.3, random_state=42)

X.shape, X_train.shape, X_test.shape
#%%
from sklearn.neighbors import KNeighborsClassifier
neigh= KNeighborsClassifier()
neigh.fit(X_train, Y_train)

Y_pred = neigh.predict(X_test)
#%%
from sklearn.metrics import confusion_matrix
confusion_matrix(Y_test, Y_pred)
#%%
from sklearn.metrics import accuracy_score
accuracy_score(Y_test, Y_pred)
#%%
from sklearn.metrics import balanced_accuracy_score
balanced_accuracy_score(Y_test, Y_pred)
#%% md
# La mejor opción a elegir es la de balanced_accuracy_score debido a que nos da una predicción correcta de ambas clases ya que al haber más datos de una clase que de otra si utilizamos la de accuracy_score tendremos una distorsión del pocentaje de acierto.
#%%
from sklearn.model_selection import GridSearchCV
parameters = {'n_neighbors': range(2,6)}
neigh= KNeighborsClassifier()
clf = GridSearchCV(neigh, parameters, scoring='balanced_accuracy')
clf.fit(X_train, Y_train)
#%%
neigh= KNeighborsClassifier(n_neighbors=3)
neigh.fit(X_train, Y_train)

Y_pred = neigh.predict(X_test)
Y_pred
#%%
confusion_matrix(Y_test, Y_pred)
#%%
accuracy_score(Y_test, Y_pred)
#%%
balanced_accuracy_score(Y_test, Y_pred)
#%% md
# Podemos ver que el hay una mejora pequeña, pero importante teniendo en cuenta que nos acercamos más al 1, lo que implica que tendrá una buena tasa de acierto. Tanto fijandonos en el accuracy como en el balanced, pero como hemos dicho antes hay que fijarse más en el balanced y en este caso tiene una mayor tasa de acierto que el accuracy
#%% md
# ## Modelo de Regresión y Evaluación
#%%
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error, r2_score
from sklearn.datasets import make_regression
#%%
X, y = make_regression(n_samples=5, n_features=2, noise=1, random_state=1)
#%%
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)
#%%
modelo = LinearRegression()
modelo.fit(X_train, y_train)
y_pred = modelo.predict(X_test)
#%%
# Evaluación del modelo
mae = mean_absolute_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
#%%
print("Mean Absolute Error (MAE): ",mae)
print("R Score:" ,r2)
#%% md
# Las predicciones del modelo se desvian del valor real por 17.23 unidades utilizando el MAE
#%% md
# ## Modelo de Clusterización y Evaluación
#%%
