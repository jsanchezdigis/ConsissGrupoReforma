using System;
using System.Collections.Generic;

namespace DL;

public partial class Proveedor
{
    public int IdProveedor { get; set; }

    public string? RazonSocial { get; set; }

    public string? Direccion { get; set; }

    public string? Telefono { get; set; }

    public virtual ICollection<Factura> Facturas { get; set; } = new List<Factura>();
}
