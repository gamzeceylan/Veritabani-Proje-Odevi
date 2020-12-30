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
//using System.Data.OleDb;

namespace HastaneOtomasyonSistemi
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            textBox2.PasswordChar = '*';
            textBox4.PasswordChar = '*';
            textBox5.PasswordChar = '*';
        }


        NpgsqlConnection baglantim = new NpgsqlConnection("Server=127.0.0.1;User Id=postgres;" +
                          "Password=hsvpr031052;Database=Hastane;");
        private void Form1_Load(object sender, EventArgs e)
        {
            this.FormBorderStyle = FormBorderStyle.FixedToolWindow;


        }

        private void button4_Click(object sender, EventArgs e)
        {
            baglantim.Open();


            NpgsqlCommand selectsorgu = new NpgsqlCommand("select*from kullanici", baglantim);
            NpgsqlDataReader kayitokuma = selectsorgu.ExecuteReader();

            while (kayitokuma.Read())
            {
                if (kayitokuma["tcno"].ToString() == textBox1.Text && kayitokuma["sifre"].ToString()==textBox2.Text )
                {
                   
                        this.Hide();
                        Hasta_Giriş frm = new Hasta_Giriş();
                        frm.Show();
                        baglantim.Close();
                        break;
                

                }
                else
                {
                    MessageBox.Show("Hatalı Giriş !");
                    baglantim.Close();
                    break;
                }


            }

         
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form2 frm = new Form2();
            frm.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            baglantim.Open();


            NpgsqlCommand selectsorgu = new NpgsqlCommand("select*from kullanici", baglantim);
            NpgsqlDataReader kayitokuma = selectsorgu.ExecuteReader();

            while (kayitokuma.Read())
            {
                if (kayitokuma["tcno"].ToString() == textBox3.Text && kayitokuma["sifre"].ToString() == textBox4.Text)
                {

                    this.Hide();
                    Doktor_Giriş frm = new Doktor_Giriş();
                    frm.Show();
                    baglantim.Close();
                    break;


                }
                else
                {
                    MessageBox.Show("Hatalı Giriş !");
                    baglantim.Close();
                    break;
                }


            }
        }

        private void button9_Click(object sender, EventArgs e)
        {
            baglantim.Open();


            NpgsqlCommand selectsorgu = new NpgsqlCommand("select*from kullanici", baglantim);
            NpgsqlDataReader kayitokuma = selectsorgu.ExecuteReader();

            while (kayitokuma.Read())
            {
                if (kayitokuma["tcno"].ToString() == textBox6.Text && kayitokuma["sifre"].ToString() == textBox5.Text)
                {

                    this.Hide();
                    Yönetici_Giriş frm = new Yönetici_Giriş();
                    frm.Show();
                    baglantim.Close();
                    break;


                }
                else
                {
                    MessageBox.Show("Hatalı Giriş !");
                    baglantim.Close();
                    break;
                }


            }

        }
    }
}
