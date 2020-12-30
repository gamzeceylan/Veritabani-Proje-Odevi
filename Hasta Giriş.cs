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
    public partial class Hasta_Giriş : Form
    {
        public Hasta_Giriş()
        {
            InitializeComponent();
            doktorgetir();
           
        }

        NpgsqlConnection baglantim = new NpgsqlConnection("Server=127.0.0.1;User Id=postgres;" +
                    "Password=hsvpr031052;Database=Hastane;");

        int rndv = 5;
        void doktorgetir()
        {
            baglantim.Open();
            NpgsqlCommand kayit = new NpgsqlCommand("select doktorid, ad, soyad, bolum, unvan from doktor ", baglantim);
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(kayit);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView2.DataSource = dt;
            baglantim.Close();
        }

        void randevugetir()
        {
            baglantim.Open();

            int id = int.Parse(textBox1.Text);
            NpgsqlCommand kayit = new NpgsqlCommand("select hasta_id, doktor_id, bolum, doktor, tarih, saat from randevu where hasta_id =@h ", baglantim);
            kayit.Parameters.AddWithValue("@h", id);
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(kayit);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            baglantim.Close();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            int id = int.Parse(textBox1.Text);
            NpgsqlCommand kayit = new NpgsqlCommand("select * from hasta where hastaid = @h; ", baglantim);

            kayit.Parameters.AddWithValue("@h", id);
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(kayit);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView3.DataSource = dt;
            baglantim.Close();
            randevugetir();
        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

            int secilen = dataGridView3.SelectedCells[0].RowIndex;
            string tc = dataGridView3.Rows[secilen].Cells[1].Value.ToString();
            string ad = dataGridView3.Rows[secilen].Cells[2].Value.ToString();
            string soyad = dataGridView3.Rows[secilen].Cells[3].Value.ToString();
            string telefon = dataGridView3.Rows[secilen].Cells[4].Value.ToString();
            string adres = dataGridView3.Rows[secilen].Cells[5].Value.ToString();

            textBox2.Text = ad;
            textBox3.Text = soyad;
            textBox4.Text = tc;
            textBox5.Text = telefon;
            textBox6.Text = adres;
          
        
        }

        private void button1_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            int id = int.Parse(textBox1.Text);
            NpgsqlCommand hastaguncelle = new NpgsqlCommand("update hasta set tcno=@h2, ad=@h3, soyad=@h4, telefon=@h5, adres=@h6 where hastaid= @h1", baglantim);
            hastaguncelle.Parameters.AddWithValue("@h1", id);
            hastaguncelle.Parameters.AddWithValue("@h2", textBox4.Text);
            hastaguncelle.Parameters.AddWithValue("@h3", textBox2.Text);
            hastaguncelle.Parameters.AddWithValue("@h4", textBox3.Text);
            hastaguncelle.Parameters.AddWithValue("@h5", textBox5.Text);
            hastaguncelle.Parameters.AddWithValue("@h6", textBox6.Text);
            hastaguncelle.ExecuteNonQuery();

            NpgsqlCommand kayit = new NpgsqlCommand("select * from hasta where hastaid = @h; ", baglantim);

            kayit.Parameters.AddWithValue("@h", id);
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(kayit);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView3.DataSource = dt;

            baglantim.Close();

        }

        private void button21_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form1 frm = new Form1();
            frm.Show();

        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox10.Clear();
            textBox11.Clear();
            textBox7.Clear();
            comboBox1.Text = "";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            rndv++;
            baglantim.Open();

            int id = int.Parse(textBox1.Text);
            int id2 = int.Parse(textBox10.Text);

            NpgsqlCommand kaydet = new NpgsqlCommand("insert into randevu (randevuid,hasta_id, doktor_id, bolum, doktor, tarih)" +
                "values (@k0, @k1, @k2, @k3, @k4, @k5)", baglantim);
            kaydet.Parameters.AddWithValue("@k0", rndv);
            kaydet.Parameters.AddWithValue("@k1", id);
            kaydet.Parameters.AddWithValue("@k2", id2);
            kaydet.Parameters.AddWithValue("@k3", comboBox1.Text);
            kaydet.Parameters.AddWithValue("@k4", textBox9.Text);
            kaydet.Parameters.AddWithValue("@k5", dateTimePicker1.Value);
            kaydet.ExecuteNonQuery();

            baglantim.Close();

            randevugetir();

            MessageBox.Show("Kaydetme Başarılı");
        }
    }
}
