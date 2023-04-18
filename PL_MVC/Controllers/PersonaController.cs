using Microsoft.AspNetCore.Mvc;
using ML;

namespace PL_MVC.Controllers
{
    public class PersonaController : Controller
    {
        [HttpGet]
        public ActionResult Add()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(ML.Persona persona)
        {
            ML.Result result = BL.Persona.Add(persona);
            if (result.Correct)
            {
                ViewBag.Message = "Se completo el registro";
            }
            else
            {
                ViewBag.Message = "Error al insertar";
            }
            return View("Modal");
        }
    }
}
