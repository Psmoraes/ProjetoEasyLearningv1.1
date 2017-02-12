using Fatec.Treinamento.Data.Repositories;
using Fatec.Treinamento.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fatec.Treinamento.Web.Controllers
{
    public class VideoController : Controller
    {
        // GET: Video
        public ActionResult Criar()
        {
            return View();
        }

        [HttpPost]

        public ActionResult Criar(Video video)
        {
            return View();
        }

        public ActionResult Editar()
        {
            return View();
        }

        [HttpPost]

        public ActionResult Editar(Video video)
        {
            return View();
        }

        public ActionResult Lista()
        {
            return View();
        }

        [HttpPost]

        public ActionResult Lista(Video video)
        {
            return View();
        }

        public ActionResult Excluir()
        {
            return View();
        }
        
        [HttpPost]

        public ActionResult Excluir(Video video)
        {
            return View();
        }
    }
}