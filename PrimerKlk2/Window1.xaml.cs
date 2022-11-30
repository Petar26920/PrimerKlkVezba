using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace PrimerKlk2
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        DomZdravljaDataContext DZ = new DomZdravljaDataContext();
        public Window1()
        {
            InitializeComponent();
            cmbFirme();
        }

        private void Grid_ContextMenuClosing(object sender, ContextMenuEventArgs e)
        {

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        //ODRADITI
        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            if (!String.IsNullOrEmpty(tbSifra.Text) || !String.IsNullOrEmpty(tbPrezime.Text) || !String.IsNullOrEmpty(tbIme.Text) || !String.IsNullOrEmpty(tbCena.Text) ||
                !String.IsNullOrEmpty(cbFirma.SelectedValue.ToString()) || !String.IsNullOrEmpty(cbPaket.SelectedValue.ToString()))
            {
                Pacijent pac = new Pacijent()
                {
                    PacijentID = int.Parse(tbSifra.Text),
                    Ime = tbIme.Text,
                    Prezime = tbPrezime.Text,
                    PaketID = int.Parse(((Paket)cbPaket.SelectedValue).PaketID.ToString()),
                    Popust = int.Parse(sliderValue.Text),
                    DatumIzmene = DateTime.Now,
                    
                };
                DZ.Pacijents.InsertOnSubmit(pac);
                try
                {
                    DZ.SubmitChanges();
                    MessageBox.Show("Uspesno unesen pacijent");
                    this.Close();
                    
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Nije uspelo"+ex.Message);
                }
            }

        }
        private void cmbFirme()
        {
            var firma = from f in DZ.Firmas
                        select f;
            cbFirma.ItemsSource = firma;
        }

        private void cbFirma_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var paket = from pak in DZ.Pakets
                        where pak.FirmaID == int.Parse(((Firma)cbFirma.SelectedValue).FirmaID.ToString())
                        select pak;
            cbPaket.ItemsSource = paket;
        }
    }
}
