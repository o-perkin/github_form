import React, { Component } from "react";
import "./App.css";
import axios from "axios";
import { Input } from "antd";
import { Button } from "antd";

const { Search } = Input;

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = { value: "", userName: "", repos: [] };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleClear = this.handleClear.bind(this);
  }

  handleChange(event) {
    this.setState({ value: event.target.value });
  }

  handleSubmit() {
    if (this.state.value != "") {
      axios
        .get(`/api/v1/?search=${this.state.value}`, {
          headers: { Accept: "*/*" },
          withCredentials: true,
        })
        .then((response) => {
          this.setState({
            userName: response.data.data.name,
            repos: response.data.data.repos,
          });
        })
        .catch((error) => {
          console.log(error);
          this.setState({
            userName: "Not Found",
            repos: [],
          });
        });
    } else {
      alert("The value cannot be empty");
    }
  }

  handleClear(event) {
    this.setState({ value: "", userName: "", repos: [] });
    event.preventDefault();
  }

  render() {
    return (
      <div className="container">
        <div className="center">
          <Search
            onChange={this.handleChange}
            value={this.state.value}
            placeholder="Input Github Login"
            onSearch={this.handleSubmit}
            enterButton
            style={{ width: "300px", marginRight: "10px" }}
          />
          <Button type="default" onClick={this.handleClear}>
            Clear
          </Button>
          <br />
          <br />
          <div>
            {this.state.userName ? (
              <div>
                <h3>Name: </h3>
                {this.state.userName}
              </div>
            ) : null}
            <br />
            {this.state.repos.length != 0 ? (
              <div>
                <h3>Repositories: </h3>
                {this.state.repos.map((el) => (
                  <p key={el}>{el}</p>
                ))}
              </div>
            ) : null}
          </div>
        </div>
      </div>
    );
  }
}
