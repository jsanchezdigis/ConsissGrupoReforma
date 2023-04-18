using Microsoft.EntityFrameworkCore;

namespace BL
{
    public class Persona
    {
        public static ML.Result Add(ML.Persona persona)
        {
            ML.Result result = new ML.Result();
            try
            {
                using (DL.JsanchezConsissContext context = new DL.JsanchezConsissContext())
                {
                    int query = context.Database.ExecuteSqlRaw($"Principal" +
                        $"'{persona.Accion}'," +
                        $"'{persona.IdPersona}'," +
                        $"'{persona.Nombre}'," +
                        $"'{persona.Direccion}'," +
                        $"'{persona.Edad}'," +
                        $"'{persona.Correo}'," +
                        $"'{persona.Habilidad}'");
                    if (query >= 1)
                    {
                        result.Correct = true;
                    }
                    else
                    {
                        result.Correct = false;
                        result.ErrorMessage = "No se inserto el registro";
                    }
                    result.Correct = true;
                }
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.ErrorMessage = ex.Message;
            }
            return result;
        }
    }
}