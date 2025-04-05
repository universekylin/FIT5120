from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
import datetime

app = Flask(__name__)

# Update connection string with correct password
DB_URI = "mysql+mysqlconnector://admin:123456@54.66.141.26/mysql_test"

app.config['SQLALCHEMY_DATABASE_URI'] = DB_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    
    def __repr__(self):
        return '<User %r>' % self.username

@app.route('/')
def home():
    try:
        # Get all users from the database
        users = User.query.all()
        
        return f"""
        <h1>MySQL Database Test</h1>
        <p>Connection: {DB_URI}</p>
        
        <h2>Add New User</h2>
        <form action="/add_user" method="post">
            <div>
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <button type="submit">Add User</button>
        </form>
        
        <h2>Current Users in Database:</h2>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
            {"".join(f"<tr><td>{user.id}</td><td>{user.username}</td><td>{user.email}</td><td><a href='/delete/{user.id}'>Delete</a></td></tr>" for user in users)}
        </table>
        """
        
    except Exception as e:
        return f"""
        <h1>Database Error</h1>
        <p>Error: {str(e)}</p>
        <p>Connection string: {DB_URI}</p>
        """

@app.route('/add_user', methods=['POST'])
def add_user():
    try:
        username = request.form.get('username')
        email = request.form.get('email')
        
        # Basic validation
        if not username or not email:
            return "Username and email are required", 400
            
        # Create new user
        new_user = User(username=username, email=email)
        db.session.add(new_user)
        db.session.commit()
        
        return redirect(url_for('home'))
    except Exception as e:
        return f"""
        <h1>Error Adding User</h1>
        <p>Error: {str(e)}</p>
        <p><a href="/">Go back</a></p>
        """

@app.route('/delete/<int:user_id>')
def delete_user(user_id):
    try:
        user = User.query.get_or_404(user_id)
        db.session.delete(user)
        db.session.commit()
        return redirect(url_for('home'))
    except Exception as e:
        return f"""
        <h1>Error Deleting User</h1>
        <p>Error: {str(e)}</p>
        <p><a href="/">Go back</a></p>
        """

@app.route('/reset_database')
def reset_database():
    try:
        db.drop_all()
        db.create_all()
        test_user = User(username='testuser', email='test@example.com')
        db.session.add(test_user)
        db.session.commit()
        return redirect(url_for('home'))
    except Exception as e:
        return f"""
        <h1>Error Resetting Database</h1>
        <p>Error: {str(e)}</p>
        <p><a href="/">Go back</a></p>
        """

if __name__ == "__main__":
    app.run(debug=True)