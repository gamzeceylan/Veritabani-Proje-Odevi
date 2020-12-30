using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using Npgsql;

namespace HastaneOtomasyonSistemi
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        NpgsqlConnection baglantim = new NpgsqlConnection("Server=127.0.0.1;User Id=postgres;" +
                        "Password=hsvpr031052;Database=Hastane;");
        private void button2_Click(object sender, EventArgs e)
        {
            baglantim.Open();

            int id = int.Parse(textBox8.Text);

            NpgsqlCommand kaydet1 = new NpgsqlCommand("insert into kullanici (kullaniciid, tcno, sifre)" +
                "values (@k1, @k2, @k3)", baglantim);
            kaydet1.Parameters.AddWithValue("@k1", id);
            kaydet1.Parameters.AddWithValue("@k2", textBox6.Text);
            kaydet1.Parameters.AddWithValue("@k3", textBox3.Text);

            kaydet1.ExecuteNonQuery();

            baglantim.Close();

            baglantim.Open();
            NpgsqlCommand kaydet = new NpgsqlCommand("insert into hasta (hastaid, tcno, ad, soyad, telefon, adres)" +
                "values (@h1, @h2, @h3, @h4, @h5, @h6)", baglantim);
            

            kaydet.Parameters.AddWithValue("@h1", id);
            kaydet.Parameters.AddWithValue("@h2", textBox6.Text);
            kaydet.Parameters.AddWithValue("@h3", textBox5.Text);
            kaydet.Parameters.AddWithValue("@h4", textBox1.Text);
            kaydet.Parameters.AddWithValue("@h5", textBox2.Text);
            kaydet.Parameters.AddWithValue("@h6", textBox7.Text);

            kaydet.ExecuteNonQuery(); //parametreler üzerinde ekleme silme değiştirme işlemi yapıldığında kullanılır

            baglantim.Close();
            MessageBox.Show("Kaydetme Başarılı");

        }

        private void button5_Click(object sender, EventArgs e)
        {
            textBox6.Clear();
            textBox5.Clear();
            textBox1.Clear();
            textBox2.Clear();
            textBox7.Clear();
            textBox3.Clear();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form1 frm = new Form1();
            frm.Show();
        }
    }
}
