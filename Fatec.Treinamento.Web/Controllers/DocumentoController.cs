using Fatec.Treinamento.Data.Repositories;
using Fatec.Treinamento.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fatec.Treinamento.Web.Controllers
{
    public class DocumentoController : Controller
    {
        // GET: Documento
        public ActionResult Criar()
        {
            return View();
        }

        [HttpPost]

        public ActionResult Criar(Documento documento)
        {
            return View();
        }

        public ActionResult Editar()
        {
            return View();
        }

        public ActionResult Editar(Documento documento)
        {
            return View();
        }

   

}
}