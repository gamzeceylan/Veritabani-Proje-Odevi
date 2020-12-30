using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;
using System.IO;

namespace HastaneOtomasyonSistemi
{
    public partial class Yönetici_Giriş : Form
    {

        NpgsqlConnection baglantim = new NpgsqlConnection("Server=127.0.0.1;User Id=postgres;" +
                      "Password=hsvpr031052;Database=Hastane;");

        public Yönetici_Giriş()
        {
            InitializeComponent();

            baglantim.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from departman", baglantim);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView6.DataSource = ds.Tables[0];

            baglantim.Close();

            calisangetir();
        }

        void doktorgetir()
        {
            baglantim.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from doktor order by doktorid asc", baglantim);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView2.DataSource = ds.Tables[0];

            baglantim.Close();
        }

        void hemsiregetir()
        {
            baglantim.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from hemsire order by hemsireid asc ", baglantim);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView3.DataSource = ds.Tables[0];

            baglantim.Close();
        }

        void personelgetir()
        {
            baglantim.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from personel order by personelid asc", baglantim);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView4.DataSource = ds.Tables[0];

            baglantim.Close();
        }
        void hastagetir()
        {
            baglantim.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from hasta order by hastaid asc", baglantim);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView5.DataSource = ds.Tables[0];

            baglantim.Close();
        }

        void calisangetir()
        {
            baglantim.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from calisan order by id asc", baglantim);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView7.DataSource = ds.Tables[0];

            baglantim.Close();

        }
        private void button5_Click(object sender, EventArgs e)
        {
            doktorgetir();
        
        }


        private void button18_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            NpgsqlDataAdapter doktorara = new NpgsqlDataAdapter("Select * From doktor_dondur ('" + textBox1.Text + "')", baglantim);
            DataSet ds = new DataSet();
            doktorara.Fill(ds);
            dataGridView2.DataSource = ds.Tables[0];

            baglantim.Close();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            hemsiregetir();

        }

        private void button7_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            NpgsqlDataAdapter hemsireara = new NpgsqlDataAdapter("Select * From hemsire_dondur ('"+textBox2.Text+"')", baglantim);
            DataSet ds = new DataSet();
            hemsireara.Fill(ds);
            dataGridView3.DataSource = ds.Tables[0];
           
            baglantim.Close();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button10_Click(object sender, EventArgs e)
        {
            baglantim.Open();

            int id = int.Parse(textBox8.Text);

            NpgsqlCommand kaydet1 = new NpgsqlCommand("insert into hemsire (hemsireid, tcno, hemsireadi, hemsiresoyadi, bolumadi)" +
                "values (@h1, @h2, @h3, @h4, @h5)", baglantim);
            kaydet1.Parameters.AddWithValue("@h1", id);
            kaydet1.Parameters.AddWithValue("@h2", textBox7.Text);
            kaydet1.Parameters.AddWithValue("@h3", textBox5.Text);
            kaydet1.Parameters.AddWithValue("@h4", textBox6.Text);
            kaydet1.Parameters.AddWithValue("@h5", comboBox1.Text);

            kaydet1.ExecuteNonQuery();

            baglantim.Close();

            hemsiregetir();

            MessageBox.Show("Kaydetme Başarılı");
        }

        private void button8_Click(object sender, EventArgs e)
        {
            baglantim.Open();

            NpgsqlCommand sil1 = new NpgsqlCommand("delete from hemsire where hemsireid= '"+textBox8.Text+"'", baglantim);
            NpgsqlCommand sil2 = new NpgsqlCommand(" delete from calisan where id= '" + textBox8.Text + "'", baglantim);
            sil1.ExecuteNonQuery();
            sil2.ExecuteNonQuery();
            baglantim.Close();

            hemsiregetir();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            int id = int.Parse(textBox8.Text);
            NpgsqlCommand hemsireguncelle = new NpgsqlCommand("update hemsire set tcno=@h2, hemsireadi=@h3, hemsiresoyadi=@h4, bolumadi=@h5 where hemsireid= @h1", baglantim);
            hemsireguncelle.Parameters.AddWithValue("@h1", id);
            hemsireguncelle.Parameters.AddWithValue("@h2", textBox5.Text);
            hemsireguncelle.Parameters.AddWithValue("@h3", textBox6.Text);
            hemsireguncelle.Parameters.AddWithValue("@h4", textBox7.Text);
            hemsireguncelle.Parameters.AddWithValue("@h5", comboBox1.Text);
            hemsireguncelle.ExecuteNonQuery();


            NpgsqlCommand calisanguncelle = new NpgsqlCommand("update calisan set  tcno=@c2, calisanadi=@c3, calisansoyadi=@c4 where id= @c1", baglantim);
            calisanguncelle.Parameters.AddWithValue("@c1", id);
            calisanguncelle.Parameters.AddWithValue("@c2", textBox5.Text);
            calisanguncelle.Parameters.AddWithValue("@c3", textBox6.Text);
            calisanguncelle.Parameters.AddWithValue("@c4", textBox7.Text);
            calisanguncelle.ExecuteNonQuery();

            baglantim.Close();

            hemsiregetir();

        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            int secilen = dataGridView3.SelectedCells[0].RowIndex;
            string no = dataGridView3.Rows[secilen].Cells[0].Value.ToString();
            string tc = dataGridView3.Rows[secilen].Cells[1].Value.ToString();
            string ad = dataGridView3.Rows[secilen].Cells[2].Value.ToString();
            string soyad = dataGridView3.Rows[secilen].Cells[3].Value.ToString();
            string bolum = dataGridView3.Rows[secilen].Cells[4].Value.ToString();

            textBox8.Text = no;
            textBox5.Text = ad;
            textBox6.Text = soyad;
            textBox7.Text = tc;
            comboBox1.Text = bolum;
        }

        private void button11_Click(object sender, EventArgs e)
        {
            personelgetir();
        }

        private void button12_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            NpgsqlDataAdapter personelara = new NpgsqlDataAdapter("Select * From personel_dondur ('" + textBox3.Text + "')", baglantim);
            DataSet ds = new DataSet();
            personelara.Fill(ds);
            dataGridView4.DataSource = ds.Tables[0];

            baglantim.Close();
        }

        private void tabPage3_Click(object sender, EventArgs e)
        {

        }

        private void label18_Click(object sender, EventArgs e)
        {

        }

        private void button15_Click(object sender, EventArgs e)
        {
            baglantim.Open();

            int id = int.Parse(textBox13.Text);
            int id2 = int.Parse(comboBox2.Text);

            NpgsqlCommand kaydet1 = new NpgsqlCommand("insert into personel (personelid, tcno, departmanid, personeladi, personemsoyadi)" +
                "values (@p1, @p2, @p3, @p4, @p5)", baglantim);
            kaydet1.Parameters.AddWithValue("@p1", id);
            kaydet1.Parameters.AddWithValue("@p2", textBox12.Text);
            kaydet1.Parameters.AddWithValue("@p3", id2);
            kaydet1.Parameters.AddWithValue("@p4", textBox9.Text);
            kaydet1.Parameters.AddWithValue("@p5", textBox10.Text);

            kaydet1.ExecuteNonQuery();

            baglantim.Close();

            personelgetir();

            MessageBox.Show("Kaydetme Başarılı");
        }

        private void button13_Click(object sender, EventArgs e)
        {
            baglantim.Open();

            NpgsqlCommand sil1 = new NpgsqlCommand("delete from personel where personelid= '" + textBox13.Text + "'", baglantim);
            NpgsqlCommand sil2 = new NpgsqlCommand(" delete from calisan where id= '" + textBox13.Text + "'", baglantim);
            sil1.ExecuteNonQuery();
            sil2.ExecuteNonQuery();
            baglantim.Close();

            personelgetir();
        }

        private void button14_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            int id = int.Parse(textBox13.Text);
            int id2 = int.Parse(comboBox2.Text);
            NpgsqlCommand personelguncelle = new NpgsqlCommand("update personel set tcno=@h2, departmanid=@h3, personeladi=@h4, personemsoyadi=@h5 where personelid= @h1", baglantim);
            personelguncelle.Parameters.AddWithValue("@h1", id);
            personelguncelle.Parameters.AddWithValue("@h2", textBox12.Text);
            personelguncelle.Parameters.AddWithValue("@h3", id2);
            personelguncelle.Parameters.AddWithValue("@h4", textBox9.Text);
            personelguncelle.Parameters.AddWithValue("@h5", textBox10.Text);
            personelguncelle.ExecuteNonQuery();


            NpgsqlCommand calisanguncelle = new NpgsqlCommand("update calisan set  tcno=@c2, calisanadi=@c3, calisansoyadi=@c4 where id= @c1", baglantim);
            calisanguncelle.Parameters.AddWithValue("@c1", id);
            calisanguncelle.Parameters.AddWithValue("@c2", textBox12.Text);
            calisanguncelle.Parameters.AddWithValue("@c3", textBox9.Text);
            calisanguncelle.Parameters.AddWithValue("@c4", textBox10.Text);
            calisanguncelle.ExecuteNonQuery();

            baglantim.Close();

            personelgetir();

        }

        private void dataGridView4_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            int secilen = dataGridView4.SelectedCells[0].RowIndex;
            string no = dataGridView4.Rows[secilen].Cells[0].Value.ToString();
            string tc = dataGridView4.Rows[secilen].Cells[1].Value.ToString();
            string departmanid = dataGridView4.Rows[secilen].Cells[2].Value.ToString();
            string adi = dataGridView4.Rows[secilen].Cells[3].Value.ToString();
            string soyadi = dataGridView4.Rows[secilen].Cells[4].Value.ToString();

            textBox13.Text = no;
            textBox9.Text = adi;
            textBox10.Text = soyadi;
            textBox12.Text = tc;
            comboBox2.Text = departmanid;
      
        }

        private void button16_Click(object sender, EventArgs e)
        {
            hastagetir();
        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView5_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button17_Click(object sender, EventArgs e)
        {

            baglantim.Open();
            NpgsqlDataAdapter hastaara = new NpgsqlDataAdapter("Select * From hasta_dondur ('" + textBox4.Text + "')", baglantim);
            DataSet ds = new DataSet();
            hastaara.Fill(ds);
            dataGridView5.DataSource = ds.Tables[0];

            baglantim.Close();
        }

        private void tabPage1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            baglantim.Open();

            int id = int.Parse(textBox19.Text);

            NpgsqlCommand kaydet = new NpgsqlCommand("insert into kullanici (kullaniciid, tcno, sifre)" +
                "values (@k1, @k2, @k3)",baglantim);
            kaydet.Parameters.AddWithValue("@k1", id);
            kaydet.Parameters.AddWithValue("@k2", textBox15.Text);
            kaydet.Parameters.AddWithValue("@k3", textBox18.Text);
            kaydet.ExecuteNonQuery();


            NpgsqlCommand kaydet1 = new NpgsqlCommand("insert into doktor (doktorid, tcno, ad, soyad, bolum, unvan, sifre)" +
                "values (@d1, @d2, @d3, @d4, @d5, @d6, @d7)", baglantim);
            kaydet1.Parameters.AddWithValue("@d1", id);
            kaydet1.Parameters.AddWithValue("@d2", textBox15.Text);
            kaydet1.Parameters.AddWithValue("@d3", textBox11.Text);
            kaydet1.Parameters.AddWithValue("@d4", textBox14.Text);
            kaydet1.Parameters.AddWithValue("@d5", comboBox3.Text);
            kaydet1.Parameters.AddWithValue("@d6", textBox16.Text);
            kaydet1.Parameters.AddWithValue("@d7", textBox18.Text);

            kaydet1.ExecuteNonQuery();

            baglantim.Close();

           doktorgetir();

            MessageBox.Show("Kaydetme Başarılı");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            int id = int.Parse(textBox19.Text);
            NpgsqlCommand doktorguncelle = new NpgsqlCommand("update doktor set tcno=@h2, ad=@h3, soyad=@h4, bolum=@h5, unvan=@h6, sifre=@h7 where doktorid= @h1", baglantim);
            doktorguncelle.Parameters.AddWithValue("@h1", id);
            doktorguncelle.Parameters.AddWithValue("@h2", textBox15.Text);
            doktorguncelle.Parameters.AddWithValue("@h3", textBox11.Text);
            doktorguncelle.Parameters.AddWithValue("@h4", textBox14.Text);
            doktorguncelle.Parameters.AddWithValue("@h5", comboBox3.Text);
            doktorguncelle.Parameters.AddWithValue("@h6", textBox16.Text);
            doktorguncelle.Parameters.AddWithValue("@h7", textBox18.Text);
            doktorguncelle.ExecuteNonQuery();


            NpgsqlCommand calisanguncelle = new NpgsqlCommand("update calisan set  tcno=@c2, calisanadi=@c3, calisansoyadi=@c4 where id= @c1", baglantim);
            calisanguncelle.Parameters.AddWithValue("@c1", id);
            calisanguncelle.Parameters.AddWithValue("@c2", textBox15.Text);
            calisanguncelle.Parameters.AddWithValue("@c3", textBox11.Text);
            calisanguncelle.Parameters.AddWithValue("@c4", textBox14.Text);
            calisanguncelle.ExecuteNonQuery();


            NpgsqlCommand kullaniciguncelle = new NpgsqlCommand("update kullanici set  tcno=@c2, sifre=@c3 where kullaniciid= @c1", baglantim);
            kullaniciguncelle.Parameters.AddWithValue("@c1", id);
            kullaniciguncelle.Parameters.AddWithValue("@c2", textBox15.Text);
            kullaniciguncelle.Parameters.AddWithValue("@c3", textBox18.Text);
            kullaniciguncelle.ExecuteNonQuery();
            baglantim.Close();

            doktorgetir();
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            int secilen = dataGridView2.SelectedCells[0].RowIndex;
            string no = dataGridView2.Rows[secilen].Cells[0].Value.ToString();
            string tcno = dataGridView2.Rows[secilen].Cells[1].Value.ToString();
            string ad = dataGridView2.Rows[secilen].Cells[2].Value.ToString();
            string soyad = dataGridView2.Rows[secilen].Cells[3].Value.ToString();
            string bolum = dataGridView2.Rows[secilen].Cells[4].Value.ToString();
            string unvan = dataGridView2.Rows[secilen].Cells[5].Value.ToString();
            string sifre = dataGridView2.Rows[secilen].Cells[6].Value.ToString();

            textBox19.Text = no;
            textBox11.Text = ad;
            textBox14.Text = soyad;
            textBox15.Text = tcno;
            comboBox3.Text = bolum;
            textBox16.Text = unvan;
            textBox18.Text = sifre;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            calisangetir();
        }

        private void button3_Click_1(object sender, EventArgs e)
        {
            textBox19.Clear();
            textBox11.Clear();
            textBox14.Clear();
            textBox15.Clear();
            textBox16.Clear();
            textBox18.Clear();
            comboBox3.Text = "";
        }

        private void button19_Click(object sender, EventArgs e)
        {
            textBox8.Clear();
            textBox5.Clear();
            textBox6.Clear();
            textBox7.Clear();
            comboBox1.Text = "";
        }

        private void button20_Click(object sender, EventArgs e)
        {
            textBox13.Clear();
            textBox9.Clear();
            textBox10.Clear();
            textBox12.Clear();
            comboBox2.Text = "";
        }

        private void button21_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form1 frm = new Form1();
            frm.Show();
        }

        
    }
}
