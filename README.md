# ocaml-dtc-pb [![Build Status](https://api.travis-ci.com/vbmithr/ocaml-dtc-pb.svg?branch=master)](https://travis-ci.com/github/deepmarker/ocaml-dtc-pb)

## Introduction

This library provides access to the [DTC
Protocol](https://dtcprotocol.org) to an OCaml program. It uses DTC's
[protobuf](https://developers.google.com/protocol-buffers) flavour,
leveraging [@alavrik](https://github.com/alavrik/)'s excellent
[piqi](http://piqi.org) library for automatic conversion of `.proto`
files into OCaml types.

## Usage

DTC is developed by the [Sierra Chart](https://www.sierrachart.com/)
team for easy interoperability between their software and software
providing market access. At DeepMarker, we use the DTC protocol on top
of our data and trading backend and use Sierra Chart as a nice
graphical client when we need one.