Console.Write("Ingrese el número de filas de las matrices: ");
int filas = int.Parse(Console.ReadLine());

Console.Write("Ingrese el número de columnas de las matrices: ");
int columnas = int.Parse(Console.ReadLine());

Console.WriteLine("Ingrese los valores de la matriz A:");
int[,] matriz1 = new int[filas, columnas];
for (int i = 0; i < filas; i++)
{
    for (int j = 0; j < columnas; j++)
    {
        Console.Write("Ingrese el valor de la fila " + (i + 1) + " y la columna " + (j + 1) + ": ");
        matriz1[i, j] = int.Parse(Console.ReadLine());
    }
}

Console.WriteLine("Ingrese los valores de la matriz B:");
int[,] matriz2 = new int[filas, columnas];
for (int i = 0; i < filas; i++)
{
    for (int j = 0; j < columnas; j++)
    {
        Console.Write("Ingrese el valor de la fila " + (i + 1) + " y la columna " + (j + 1) + ": ");
        matriz2[i, j] = int.Parse(Console.ReadLine());
    }
}

Console.WriteLine("Matriz A:");
for (int i = 0; i < filas; i++)
{
    for (int j = 0; j < columnas; j++)
    {
        Console.Write(matriz1[i, j] + " ");
    }
    Console.WriteLine();
}

Console.WriteLine("Matriz B:");
for (int i = 0; i < filas; i++)
{
    for (int j = 0; j < columnas; j++)
    {
        Console.Write(matriz2[i, j] + " ");
    }
    Console.WriteLine();
}

Console.WriteLine("Resultado:");
int[,] resultado = new int[filas, columnas];
for (int i = 0; i < filas; i++)
{
    for (int j = 0; j < columnas; j++)
    {
        resultado[i, j] = matriz1[i, j] + matriz2[i, j];
        Console.Write(resultado[i, j] + " ");
    }
    Console.WriteLine();
}

Console.ReadLine();