#!/bin/bash

function ask() {
	read -p "$1 (Y/n): " response
	[ -z "$response" ] || [ "$response" = "y" ]
}

function ismac() {
	[ -z "$(uname)" ] || [ "$(uname)" = "Darwin" ]
}

