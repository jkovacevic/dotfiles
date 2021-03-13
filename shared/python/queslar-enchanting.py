import tkinter as tk
import requests

LABEL_WIDTH = 15
FIELD_WIDTH = 20
RESULT_HEIGHT = 50
PADDING_X = 5
PADDING_Y = 2
MATERIAL_LEFTOVER = 100000

API_KEY="9af0a976ceb684ce5766847b8e43d033cb828e4f7f090ce98a282bb4e969b022"

class Application(tk.Frame):
    
    def __init__(self, master=None):
        super().__init__(master)
        self.master = master
        self.pack(fill=tk.BOTH, expand=True)
        self.create_widgets()
        self.populate_widgets()

    
    def create_widgets(self):
        self.frame1 = tk.Frame(self)
        self.frame1.pack(fill=tk.X)
        self.label_player_gold = tk.Label(self.frame1, text="Player gold:", width=LABEL_WIDTH)
        self.label_player_gold.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_player_gold = tk.Entry(self.frame1, width=FIELD_WIDTH)
        self.field_player_gold.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame2 = tk.Frame(self)
        self.frame2.pack(fill=tk.X)
        self.label_player_relic = tk.Label(self.frame2, text="Player relic:", width=LABEL_WIDTH)
        self.label_player_relic.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_player_relic = tk.Entry(self.frame2, width=FIELD_WIDTH)
        self.field_player_relic.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.label_market_relic = tk.Label(self.frame2, text="Price relic:", width=LABEL_WIDTH)
        self.label_market_relic.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_market_relic = tk.Entry(self.frame2, width=FIELD_WIDTH)
        self.field_market_relic.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame3 = tk.Frame(self)
        self.frame3.pack(fill=tk.X)
        self.label_player_meat = tk.Label(self.frame3, text="Player meat:", width=LABEL_WIDTH)
        self.label_player_meat.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_player_meat = tk.Entry(self.frame3, width=FIELD_WIDTH)
        self.field_player_meat.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.label_market_meat = tk.Label(self.frame3, text="Price meat:", width=LABEL_WIDTH)
        self.label_market_meat.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_market_meat = tk.Entry(self.frame3, width=FIELD_WIDTH)
        self.field_market_meat.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame4 = tk.Frame(self)
        self.frame4.pack(fill=tk.X)
        self.label_player_iron = tk.Label(self.frame4, text="Player iron:", width=LABEL_WIDTH)
        self.label_player_iron.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_player_iron = tk.Entry(self.frame4, width=FIELD_WIDTH)
        self.field_player_iron.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.label_market_iron = tk.Label(self.frame4, text="Price iron:", width=LABEL_WIDTH)
        self.label_market_iron.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_market_iron = tk.Entry(self.frame4, width=FIELD_WIDTH)
        self.field_market_iron.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame5 = tk.Frame(self)
        self.frame5.pack(fill=tk.X)
        self.label_player_wood = tk.Label(self.frame5, text="Player wood:", width=LABEL_WIDTH)
        self.label_player_wood.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_player_wood = tk.Entry(self.frame5, width=FIELD_WIDTH)
        self.field_player_wood.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.label_market_wood = tk.Label(self.frame5, text="Price wood:", width=LABEL_WIDTH)
        self.label_market_wood.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_market_wood = tk.Entry(self.frame5, width=FIELD_WIDTH)
        self.field_market_wood.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame6 = tk.Frame(self)
        self.frame6.pack(fill=tk.X)
        self.label_player_stone = tk.Label(self.frame6, text="Player stone:", width=LABEL_WIDTH)
        self.label_player_stone.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_player_stone = tk.Entry(self.frame6, width=FIELD_WIDTH)
        self.field_player_stone.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.label_market_stone = tk.Label(self.frame6, text="Price stone:", width=LABEL_WIDTH)
        self.label_market_stone.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_market_stone = tk.Entry(self.frame6, width=FIELD_WIDTH)
        self.field_market_stone.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame_ = tk.Frame(self)
        self.frame_.pack(fill=tk.X)
        tk.Label(self.frame_, width=LABEL_WIDTH).pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame9 = tk.Frame(self)
        self.frame9.pack(fill=tk.X)
        self.label_relic_req = tk.Label(self.frame9, text="Relic required:", width=LABEL_WIDTH)
        self.label_relic_req.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_relic_req = tk.Entry(self.frame9, width=FIELD_WIDTH)
        self.field_relic_req.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame10 = tk.Frame(self)
        self.frame10.pack(fill=tk.X)
        self.label_mat_req = tk.Label(self.frame10, text="Materials required:", width=LABEL_WIDTH)
        self.label_mat_req.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_mat_req = tk.Entry(self.frame10, width=FIELD_WIDTH)
        self.field_mat_req.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame_ = tk.Frame(self)
        self.frame_.pack(fill=tk.X)
        tk.Label(self.frame_, width=LABEL_WIDTH).pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame7 = tk.Frame(self)
        self.frame7.pack(fill=tk.X)
        self.label_gold_perhour = tk.Label(self.frame7, text="Gold per hour:", width=LABEL_WIDTH)
        self.label_gold_perhour.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_gold_perhour = tk.Entry(self.frame7, width=FIELD_WIDTH)
        self.field_gold_perhour.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame8 = tk.Frame(self)
        self.frame8.pack(fill=tk.X)
        self.label_relics_perhour = tk.Label(self.frame8, text="Relics per hour:", width=LABEL_WIDTH)
        self.label_relics_perhour.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)
        self.field_relics_perhour = tk.Entry(self.frame8, width=FIELD_WIDTH)
        self.field_relics_perhour.pack(side=tk.LEFT, padx=PADDING_X, pady=PADDING_Y)

        self.frame12 = tk.Frame(self)
        self.frame12.pack(fill=tk.X)
        self.button_calc = tk.Button(self.frame12, text="Calculate", command=self.calculate)
        self.button_calc.pack(expand=True, padx=PADDING_X, pady=PADDING_Y)

        self.frame13 = tk.Frame(self)
        self.frame13.pack(fill=tk.X)
        self.field_result = tk.Text(self.frame13, width=FIELD_WIDTH)
        self.field_result.pack(fill=tk.BOTH, expand=True, padx=PADDING_X + 10, pady=PADDING_Y + 10)

    
    def populate_widgets(self):
        player_data = self.query_player_data()
        market_data = self.query_market_data()

        self.field_player_gold.insert(0, player_data['gold'])
        self.field_player_relic.insert(0, player_data['relics'])
        self.field_player_meat.insert(0, player_data['meat'])
        self.field_player_iron.insert(0, player_data['iron'])
        self.field_player_wood.insert(0, player_data['wood'])
        self.field_player_stone.insert(0, player_data['stone'])
        
        self.field_market_relic.insert(0, [x for x in market_data if x['currency_type'] == 'relics'][0]['price'])
        self.field_market_meat.insert(0, [x for x in market_data if x['currency_type'] == 'meat'][0]['price'])
        self.field_market_iron.insert(0, [x for x in market_data if x['currency_type'] == 'iron'][0]['price'])
        self.field_market_wood.insert(0, [x for x in market_data if x['currency_type'] == 'wood'][0]['price'])
        self.field_market_stone.insert(0, [x for x in market_data if x['currency_type'] == 'stone'][0]['price'])

        self.field_relic_req.insert(0, 544000)
        self.field_mat_req.insert(0, 2720000)

        self.field_gold_perhour.insert(0, 2206950)
        self.field_relics_perhour.insert(0, 45887)

    def calculate(self):
        # TODO handle negative difference
        purchase_relic = fv(self.field_relic_req) - fv(self.field_player_relic)
        purchase_meat = fv(self.field_mat_req) - fv(self.field_player_meat) + MATERIAL_LEFTOVER
        purchase_iron = fv(self.field_mat_req) - fv(self.field_player_iron) + MATERIAL_LEFTOVER
        purchase_wood = fv(self.field_mat_req) - fv(self.field_player_wood) + MATERIAL_LEFTOVER
        purchase_stone = fv(self.field_mat_req) - fv(self.field_player_stone) + MATERIAL_LEFTOVER

        gold_required =  - fv(self.field_player_gold) + \
                         purchase_relic * fv(self.field_market_relic) + \
                         purchase_meat * fv(self.field_market_meat) + \
                         purchase_iron * fv(self.field_market_iron) + \
                         purchase_wood * fv(self.field_market_wood) + \
                         purchase_stone * fv(self.field_market_stone)
        
        total_gold_per_hour = fv(self.field_gold_perhour) + fv(self.field_relics_perhour) * fv(self.field_market_relic)
        time_remaining = gold_required / total_gold_per_hour

        result_str = (
            f"Gold required: {gold_required:,} gold\n"
            f"Time: {convert_time(time_remaining)}\n\n"
            f"Meat purchase: {purchase_meat:,}\n"
            f"Iron purchase: {purchase_iron:,}\n"
            f"Wood purchase: {purchase_wood:,}\n"
            f"Stone purchase: {purchase_stone:,}"
            )

        self.field_result.delete(1.0, tk.END)
        self.field_result.insert(tk.END, result_str)


    def query_player_data(self):
        url = f"https://queslar.com/api/player/currency/{API_KEY}"
        r = requests.get(url)
        return r.json()


    def query_market_data(self):
        url = f"https://queslar.com/api/market/history-latest/{API_KEY}"
        r = requests.get(url)
        market_data = [x for x in r.json() if \
                x['market_type'] == 'buy' and \
                x['currency_type'] in ['meat', 'iron', 'wood', 'stone', 'relics']]
        return market_data


def fv(entry: tk.Entry):
    return int(entry.get().split(".")[0].replace(",", ""))

def convert_time(time: float):
    hours = int(time)
    minutes = (time*60) % 60
    seconds = (time*3600) % 60
    return f"{hours:.0f}h {minutes:.0f}min {seconds:.0f}sec"

root = tk.Tk()
root.attributes('-type', 'dialog')
app = Application(master=root)
app.mainloop()