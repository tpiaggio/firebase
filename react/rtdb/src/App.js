import './App.css';
import TimeList from "./components/TimesList";
import TimeForm from "./components/TimeForm";

function App() {

  return (
    <div className="App">
      <h1>Time Tracker</h1>
      <TimeList />
      <TimeForm />
    </div>
  );
}

export default App;
