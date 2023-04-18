Console.Write("Ingrese un número entero: ");
int numero = int.Parse(Console.ReadLine());

int factorial = 1;
for (int i = 1; i <= numero; i++)
{
    factorial *= i;
}

Console.WriteLine("El factorial de " + numero + " es " + factorial);

Console.ReadLine();
