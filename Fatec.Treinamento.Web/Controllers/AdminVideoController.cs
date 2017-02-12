using Fatec.Treinamento.Data.Repositories;
using Fatec.Treinamento.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fatec.Treinamento.Web.Controllers
{
    public class AdminVideoController : Controller
    {
        // GET: AdminVideo
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Criar()
        {
            VideoRepository capitulos = new VideoRepository();

            Video video = new Video();

            Video.Capitulo = capitulos.ListarCapitulo();

            return View(capitulos);
        }

        [HttpPost]

        public ActionResult Criar(Video video)
        {
            VideoRepository curso = new VideoRepository();

            video.Inserir(video);

            video.Capitulos = curso.ListarCapitulo();

            return View(video);
        }
    }
}