from flask import Flask, render_template, request, redirect, url_for
import session_items as session
import requests as Requests
import secrets
from Item import Item

app = Flask(__name__)
app.config.from_object('flask_config.Config')

@app.route('/')
def index():
    item_list = []
    list_id = '5f56323626c33d81cd98b386'
    r = Requests.get(f'https://api.trello.com/1/lists/{list_id}/cards?key={secrets.KEY}&token={secrets.TOKEN}')
    for items in (r.json()):
        item_list.append( Item(items['id'], 'To Do', items['name']) )
    return render_template("index.html", items=item_list)

@app.route('/newItem', methods=['POST'])
def submitNewItem():
    item_name = request.form.get('itemName')
    list_id = '5f56323626c33d81cd98b386'
    url = f"https://api.trello.com/1/cards"
    query = {
        'key': secrets.KEY,
        'token': secrets.TOKEN,
        'idList': list_id,
        "name": str(item_name)
    }
    Requests.request(
        "POST",
        url,
        params=query
    )
    return redirect('/')

@app.route('/markAsComplete/<item_id>')
def markAsComplete(item_id):
    item_key = item_id
    list_to_move_to = '5f56324465484e35d83eb45b'
    list_id = '5f56323626c33d81cd98b386'
    Requests.put('https://api.trello.com/1/cards/{}?key={}&token={}&idList={}'.format(item_key, secrets.KEY, secrets.TOKEN, list_to_move_to))
    return redirect('/') 

if __name__ == '__main__':
    app.run()
