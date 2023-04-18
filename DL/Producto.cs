using System;
using System.Collections.Generic;

namespace DL;

public partial class Producto
{
    public int IdProducto { get; set; }

    public string? Descripcion { get; set; }

    public decimal? PrecioUnitario { get; set; }

    public virtual ICollection<DetalleFactura> DetalleFacturas { get; set; } = new List<DetalleFactura>();
}
