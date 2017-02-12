using Fatec.Treinamento.Data.Repositories;
using Fatec.Treinamento.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fatec.Treinamento.Web.Controllers
{
    public class Trilha_CursoController : Controller
    {
        // GET: Trilha_Curso
        public ActionResult Criar()
        {
            return View ();
        }

            [HttpPost]
        public ActionResult Criar(Trilha_Curso trilha_curso)
        {
            return View();
        }

        public ActionResult Editar()
        {
            return View();
        }

        [HttpPost]

        public ActionResult Editar(Trilha_Curso trilha_curso)
        {
            return View();
        }
    }
}