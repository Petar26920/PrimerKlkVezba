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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace PrimerKlk2
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        DomZdravljaDataContext DZ = new DomZdravljaDataContext();
        public MainWindow()
        {
            InitializeComponent();
            punicmbFirme();
        }
        private void punicmbFirme()
        {
            var firma = from f in DZ.Firmas
                        select f;
            cmbFirma.ItemsSource = firma;
        }
        public void puniGrid()
        {
            var pacijent = from p in DZ.Pacijents
                           join pak in DZ.Pakets on p.PaketID equals pak.PaketID
                           join fir in DZ.Firmas on pak.FirmaID equals fir.FirmaID
                           where fir.FirmaID == int.Parse(((Firma)cmbFirma.SelectedValue).FirmaID.ToString()) && pak.PaketID == p.PaketID
                           select p;
            dgPacijent.ItemsSource = pacijent;
        }

        private void cmbFirma_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            puniGrid();
            ukupno();
        }

        private void dgPacijent_LoadingRowDetails(object sender, DataGridRowDetailsEventArgs e)
        {
            var pak = (from p in DZ.Pakets
                       join pac in DZ.Pacijents on p.PaketID equals pac.PaketID
                       where p.PaketID == int.Parse(((Pacijent)dgPacijent.SelectedValue).PaketID.ToString())
                       select new { p.Naziv, p.Cena, pac.Popust }).FirstOrDefault();



            TextBox tb1 = e.DetailsElement.FindName("tbNaziv") as TextBox;
            tb1.Text = pak.Naziv.ToString();
            TextBox tb2 = e.DetailsElement.FindName("tbCena") as TextBox;
            tb2.Text = pak.Cena.ToString();
            TextBox tb3 = e.DetailsElement.FindName("tbPopust") as TextBox;
            tb3.Text = pak.Popust.ToString();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {

        }
        private void ukupno()
        {
            var uk = (from p in DZ.Pacijents
                      join pak in DZ.Pakets on p.PaketID equals pak.PaketID
                      join fir in DZ.Firmas on pak.FirmaID equals fir.FirmaID
                      where fir.FirmaID == int.Parse(((Firma)cmbFirma.SelectedValue).FirmaID.ToString()) && pak.PaketID == p.PaketID
                      select p).Count();

            tbUkupno.Text = "Ukupno pacijenata u firmi: " + uk.ToString();

        }

        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            Pacijent pacijent = (from p in DZ.Pacijents
                                 where p.PacijentID == int.Parse(((Pacijent)dgPacijent.SelectedValue).PacijentID.ToString())
                                 select p).FirstOrDefault();

            MessageBoxResult rez = MessageBox.Show("Da li ste sigurni da zelite da obrisete pacijenta?", "", MessageBoxButton.YesNo);
            if (rez == MessageBoxResult.Yes)
            {
                DZ.Pacijents.DeleteOnSubmit(pacijent);
                try
                {
                    DZ.SubmitChanges();
                    MessageBox.Show("Pacijent obrisan");
                    puniGrid();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Unable to delete!" + ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Pacijent nije obrisan");
            }
        }

        private void MenuItem_Click_1(object sender, RoutedEventArgs e)
        {
            gbPopust.IsEnabled = true;
            tbSifra.Text = (((Pacijent)dgPacijent.SelectedValue).PacijentID.ToString());
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (!String.IsNullOrEmpty(tbSifra.Text) || !String.IsNullOrEmpty(tbPopust.Text))
            {
                Pacijent popust = (from p in DZ.Pacijents
                                   where p.PacijentID == int.Parse(tbSifra.Text)
                                   select p).FirstOrDefault();
                popust.Popust = int.Parse(tbPopust.Text);
                try
                {
                    DZ.SubmitChanges();
                    MessageBox.Show("Uspesno promenjen popust za pacijenta.");
                    puniGrid();
                }
                catch (Exception)
                {
                    MessageBox.Show("Nije uspela promena popusta. Pokusajte ponovo.");
                    throw;
                }
            }
            else
            {
                MessageBox.Show("Sva polja moraju biti popunjena.", "Obavestenje", MessageBoxButton.OK, MessageBoxImage.Information);
            }


            gbPopust.IsEnabled = false;
        }
        //ODRADITI
        private void rbMax_Checked(object sender, RoutedEventArgs e)
        {
            if (rbMax.IsChecked == true)
            {
                var max = (from pac in DZ.Pacijents
                           join pak in DZ.Pakets on pac.PaketID equals pak.PaketID
                           join f in DZ.Firmas on pak.FirmaID equals f.FirmaID
                           where f.FirmaID == int.Parse(((Firma)cmbFirma.SelectedValue).FirmaID.ToString())
                           select new { pac.PacijentID, pak.Naziv, pac.Popust }).Max(pac => pac.Popust);

                var paci = from p in DZ.Pacijents
                           join paket in DZ.Pakets on p.PaketID equals paket.PaketID
                           where p.Popust == max
                           select new { p.PacijentID, paket.Naziv,p.Popust };
                lbMax.ItemsSource = paci;

            }
            else if(rbMin.IsChecked==true)
            {
                var min = (from pac in DZ.Pacijents
                           join pak in DZ.Pakets on pac.PaketID equals pak.PaketID
                           join f in DZ.Firmas on pak.FirmaID equals f.FirmaID
                           where f.FirmaID == int.Parse(((Firma)cmbFirma.SelectedValue).FirmaID.ToString())
                           select new { pac.PacijentID, pak.Naziv, pac.Popust }).Min(pac => pac.Popust);
                var paci = from p in DZ.Pacijents
                           join paket in DZ.Pakets on p.PaketID equals paket.PaketID
                           where p.Popust == min
                           select new { p.PacijentID, paket.Naziv, p.Popust };
                lbMax.ItemsSource = paci;
            }




        }

        private void MenuItem_Click_2(object sender, RoutedEventArgs e)
        {
            Window1 w = new Window1();
            w.Show();
        }
    }
    }
