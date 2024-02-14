from flask import render_template, request, flash
from flask_mail import Message
from app import app, mail
from dotenv import load_dotenv
import os
from threading import Thread

load_dotenv()

def send_async_email(app, msg):
    with app.app_context():
        mail.send(msg)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if(request.method=='POST'):
        name=request.form['name']
        email=request.form['email']
        phone=request.form['phone']
        subject=request.form['subject']
        message=request.form['message']
        msg = Message('New enquiry from ' + name + ' - ' + subject,
                      sender='kashconails@gmail.com',
                        recipients=['kashconails@gmail.com'])
        msg.body = f'{email} \n {phone} \n {message}' 
        thr = Thread(target=send_async_email, args=[app, msg])
        thr.start()
        send_email_confirmation(name, email, subject, message)
        flash("Thank you for your enquiry. We will get back to you as soon as possible. Please check your email for a copy of your enquiry.")
    return render_template('contact.html', title='Contact')

@app.route('/products/<string:product>', methods=['GET', 'POST'])
def products(product):
    if(request.method=='POST'):
        productName=request.form['product-name']
        name=request.form['name']
        email=request.form['email']
        phone=request.form['phone']
        message=request.form['message']
        msg = Message('New enquiry from ' + name + ' for ' + productName,
                        sender='kashconails@gmail.com',
                        recipients=['kashconails@gmail.com'])
        msg.body = f'{email} \n {phone} \n {message}' 
        thr = Thread(target=send_async_email, args=[app, msg])
        thr.start()
        send_email_confirmation(name, email, productName, message)
        flash("Thank you for your enquiry. We will get back to you as soon as possible. Please check your email for a copy of your enquiry.")
    if(product=="brad_nail"):
        return render_template('brad_nail.html')
    elif(product=="coil_nail"):
        return render_template('coil_nail.html')
    elif(product=="staples"):
        return render_template('staples.html')
    

def send_email_confirmation(name, email, subject, message):
    msg = Message('Thank you for your enquiry',
                  sender='kashconails@gmail.com',
                  recipients=[email])
    msg.body = f'Hi {name}, \n\nThank you for your enquiry with Kashco Nails. \n\nHere is a copy of your query: {subject}\n{message}\n\nWe will get back to you as soon as possible. \n\nKind regards, \nKashco Nails'
    thr = Thread(target=send_async_email, args=[app, msg])
    thr.start()

if __name__ == '__main__':
    app.run(debug=True)
