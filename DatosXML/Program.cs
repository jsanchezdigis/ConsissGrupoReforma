using System.Xml;
using System.Xml.Linq;

//crear un objeto con con el archivo original
XmlDocument doc = new XmlDocument();
doc.Load("C:\\Users\\ALIEN09\\Documents\\Sanchez Xihuitl Jose de Jesus\\Examen Consiss Grupo Reforma práctico\\DatosXML.xml");
//la creacion del nuevo archivo
XmlDocument docnuevo = new XmlDocument();

//Colocar la declaracion inicial en este caso <?xml version="1.0" encoding="ISO-8859-1"?>
XmlDeclaration xmlDeclaration = docnuevo.CreateXmlDeclaration("1.0", "ISO-8859-1", null);
//Se agrega al nuevo archivo
docnuevo.AppendChild(xmlDeclaration);
//Se crea el Nodo de info y se agrega al nuevo archivo
XmlNode infoNone = docnuevo.CreateElement("info");
docnuevo.AppendChild(infoNone);

//Se selecciona el nodo noticias del archivo original
XmlNode noticiasNone = doc.SelectSingleNode("/noticias");
//Una iteracion del coontenido de noticias con noticia ya que este tiene todos los datos
foreach(XmlNode noticiaNone in noticiasNone.ChildNodes)
{
    //Se crea el nodo potcast y dentro de el los atributos de tipo,libre,id,is3idfp,idaudio de acuerdo a los datos seleccionados desde el archivo original
    XmlNode podcastNone = docnuevo.CreateElement("podcast");
    podcastNone.Attributes.Append(docnuevo.CreateAttribute("tipo")).Value = noticiaNone.Attributes["tipo"].Value;
    podcastNone.Attributes.Append(docnuevo.CreateAttribute("libre")).Value = noticiaNone.SelectSingleNode("libre").InnerText;
    podcastNone.Attributes.Append(docnuevo.CreateAttribute("id")).Value = noticiaNone.SelectSingleNode("id").InnerText;
    podcastNone.Attributes.Append(docnuevo.CreateAttribute("is3idfp")).Value = noticiaNone.SelectSingleNode("is3idfp").InnerText;
    podcastNone.Attributes.Append(docnuevo.CreateAttribute("idaudio")).Value = noticiaNone.SelectSingleNode("idaudio").InnerText;

    //Se crean los nodos de categoria, titulo, resumen, prevurl, url, estos estan dentro de potcast y se agregan al nuevo archivo
    XmlNode categoriaNode = docnuevo.CreateElement("categoria");
    categoriaNode.InnerText = noticiaNone.SelectSingleNode("categoria").InnerText;
    podcastNone.AppendChild(categoriaNode);

    XmlNode tituloNode = docnuevo.CreateElement("titulo");
    tituloNode.InnerText = noticiaNone.SelectSingleNode("titulo").InnerText;
    podcastNone.AppendChild(tituloNode);

    XmlNode resumenNode = docnuevo.CreateElement("resumen");
    resumenNode.InnerText = noticiaNone.SelectSingleNode("resumen").InnerText;
    podcastNone.AppendChild(resumenNode);

    XmlNode prevurlNode = docnuevo.CreateElement("prevurl");
    prevurlNode.InnerText = noticiaNone.SelectSingleNode("prevurl").InnerText;
    podcastNone.AppendChild(prevurlNode);

    XmlNode urlNode = docnuevo.CreateElement("url");
    urlNode.InnerText = noticiaNone.SelectSingleNode("url").InnerText;
    podcastNone.AppendChild(urlNode);

    //se agrega los datos de potcast dentro de info
    infoNone.AppendChild(podcastNone);
}
//Se muestra en consola el archivo nuevo
Console.WriteLine(docnuevo.OuterXml);
Console.ReadKey();
//Se guarda como nuevo archivo xml 
docnuevo.Save("C:\\Users\\ALIEN09\\Documents\\Sanchez Xihuitl Jose de Jesus\\Examen Consiss Grupo Reforma práctico\\xml_Datos.xml");

