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
    public partial class Doktor_Giriş : Form
    {
        public Doktor_Giriş()
        {
            InitializeComponent();
        }

        NpgsqlConnection baglantim = new NpgsqlConnection("Server=127.0.0.1;User Id=postgres;" +
                  "Password=hsvpr031052;Database=Hastane;");
        void randevugeetir()
        {
            baglantim.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from hasta", baglantim);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];

            baglantim.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            textBox5.Clear();
            checkBox1.Checked = false;
            textBox6.Clear();
            textBox3.Clear();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            int id = int.Parse(textBox4.Text);

            NpgsqlCommand randevusil = new NpgsqlCommand("Delete From randevu where hasta_id = @hastaid", baglantim);
            randevusil.Parameters.AddWithValue("@hastaid", id);
            randevusil.ExecuteNonQuery();

            NpgsqlCommand kaydetilac = new NpgsqlCommand("insert into ilac (ilacadi) values (@ilacadi)", baglantim);
            kaydetilac.Parameters.AddWithValue("@ilacadi", textBox3.Text);
            kaydetilac.ExecuteNonQuery();

         

            if ( checkBox1.Checked==true)
            {
                NpgsqlCommand kaydetmuayne = new NpgsqlCommand("insert into muayne (aciklama) values ('Muayne Edildi')", baglantim);

            }


            baglantim.Close();

            randevugeetir();

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            int secilen = dataGridView1.SelectedCells[0].RowIndex;
            string id = dataGridView1.Rows[secilen].Cells[1].Value.ToString();
            string tcno = dataGridView1.Rows[secilen].Cells[2].Value.ToString();
            string ad = dataGridView1.Rows[secilen].Cells[3].Value.ToString();
            string soyad = dataGridView1.Rows[secilen].Cells[4].Value.ToString();

            textBox4.Text = id;
            textBox1.Text = ad;
            textBox5.Text = soyad;
            textBox6.Text = tcno;
            
        }

        private void button3_Click(object sender, EventArgs e)
        {
            baglantim.Open();
            int id = int.Parse(textBox2.Text);
            NpgsqlCommand kayit = new NpgsqlCommand("select r.doktor_id, h.hastaid, h.tcno,h.ad,h.soyad, r.tarih, r.saat from randevu as r inner join hasta as h on r.hasta_id = h.hastaid inner join doktor as d on r.doktor_id = d.doktorid where doktor_id = @k; ", baglantim);

            kayit.Parameters.AddWithValue("@k", id);
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(kayit);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            baglantim.Close();

        }

        private void button21_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form1 frm = new Form1();
            frm.Show();
        }
    }
}
