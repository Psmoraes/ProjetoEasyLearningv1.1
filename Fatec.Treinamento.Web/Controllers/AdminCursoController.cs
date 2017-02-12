using Fatec.Treinamento.Data.Repositories;
using Fatec.Treinamento.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fatec.Treinamento.Web.Controllers
{
    public class AdminCursoController : Controller
    {
        // GET: AdminCurso
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Criar()
        {
            AssuntoRepository Repor = new AssuntoRepository();
            UsuarioRepository Repor1 = new UsuarioRepository();
            Curso Repor2 = new Curso();
            Repor2.ListaAssunto = Repor.Listar();
            Repor2.ListaUsuario = Repor1.Listar();
            
            return View(Repor2);
        }

        [HttpPost ]

        public ActionResult Criar(Curso curso)
        {

            CursoRepository Repor = new CursoRepository();
            Repor.Inserir(curso);


            AssuntoRepository Repor3 = new AssuntoRepository();
            UsuarioRepository Repor1 = new UsuarioRepository();
            Curso Repor2 = new Curso();
            Repor2.ListaAssunto = Repor3.Listar();
            Repor2.ListaUsuario = Repor1.Listar();

            return View(Repor2);
        }

    }
}