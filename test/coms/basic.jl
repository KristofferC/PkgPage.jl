@testset "lx_lead" begin
    c = lxmock(raw"""\lead{Hello goodbye baz}""")
    @test lx_lead(c,0) == "@@lead Hello goodbye baz @@"
end

@testset "lx_figure" begin
    c = lxmock(raw"""\figure{path="/assets/img.png"}""")
    @test isapproxstr(lx_figure(c,0), """~~~
        <figure class="figure">
          <img src=\"/assets/img.png\" alt=\"\" class=\"figure-img img-fluid \" width=\"\" >
        </figure>~~~""")
    c = lxmock(raw"""\figure{path="/assets/img.png",width="100%",caption="foo"}""")
    @test isapproxstr(lx_figure(c,0), """~~~
        <figure class="figure">
          <img src=\"/assets/img.png\" alt=\"foo\" class=\"figure-img img-fluid \" width=\"100%\" >
          <figcaption class="figure-caption">foo</figcaption>
        </figure>~~~""")
end

@testset "lx_alert" begin
    c = lxmock("""\\alert{foo **bar** baz}""")
    @test isapproxstr(lx_alert(c,0), """~~~
        <div class="alert alert-info" role="alert">
          ~~~
          foo **bar** baz
          ~~~
        </div>~~~""")
end

@testset "lx_table" begin
    c = lxmock("""\\table{\"\"\"
        | A   | B   |
        | --- | --- |
        | 0   | 1   |
        \"\"\", caption="a table", class="table-striped"}""")
    @test isapproxstr(lx_table(c,0), """~~~
        <table class="table table-striped">
        <caption>a table</caption>
        <thead>
          <tr>
            <th align=\"left\">A</th>
            <th align=\"left\">B</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td align=\"left\">0</td>
            <td align=\"left\">1</td>
          </tr>
        </tbody>
        </table>~~~""")
end
