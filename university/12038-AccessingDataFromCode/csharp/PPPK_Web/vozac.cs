
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------


namespace PPPK_Web
{

using System;
    using System.Collections.Generic;
    
public partial class vozac
{

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public vozac()
    {

        this.putni_nalog = new HashSet<putni_nalog>();

        this.zauzece_vozac = new HashSet<zauzece_vozac>();

    }


    public int id { get; set; }

    public string ime { get; set; }

    public string prezime { get; set; }

    public string broj_mobitela { get; set; }

    public string broj_vozacke { get; set; }



    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]

    public virtual ICollection<putni_nalog> putni_nalog { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]

    public virtual ICollection<zauzece_vozac> zauzece_vozac { get; set; }

}

}
