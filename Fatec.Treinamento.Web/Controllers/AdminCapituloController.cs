using Fatec.Treinamento.Data.Repositories;
using Fatec.Treinamento.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fatec.Treinamento.Web.Controllers
{
    public class AdminCapituloController : Controller
    {
        // GET: AdminCapitulo
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Criar()
        {
            CapituloRepository curso = new CapituloRepository();
            
            Capitulo capitulo = new Capitulo();
         
            capitulo.Cursos = curso.ListarCursos();

            return View(capitulo);
        }

        [HttpPost]

        public ActionResult Criar(Capitulo capitulo)
        {
            CapituloRepository curso = new CapituloRepository();
            
            curso.Inserir(capitulo);

            capitulo.Cursos = curso.ListarCursos();

            return View(capitulo);
        }
    }
}