-- typst-math.lua
-- A Quarto filter to handle math expressions for Typst output
-- Version: 1.0.0
-- Heavy inspiration from @cderv:
-- https://github.com/quarto-dev/quarto-cli/discussions/11368#discussioncomment-11228593

-- Check if required dependencies are available
if not quarto then
  error("This filter requires Quarto")
end

-- Helper function to check if we're outputting to Typst
local function is_typst_output()
  return quarto.doc.is_format('typst')
end

-- Helper function to wrap math content in Typst math delimiters
local function wrap_math(content)
  return '$' .. content .. '$'
end

-- Handle inline math expressions
function Math(math)
  if not is_typst_output() then
    return nil
  end
  
  if math.mathtype == "InlineMath" then
    return pandoc.RawInline('typst', wrap_math(math.text))
  end
  -- Let DisplayMath be handled by the Para filter
  return nil
end

-- Handle display math expressions within paragraphs
function Para(para)
  if not is_typst_output() then
    return nil
  end
  
  -- Check if this paragraph contains display math
  if #para.content == 1 and 
     para.content[1].t == "Math" and 
     para.content[1].mathtype == "DisplayMath" then
    -- Convert to centered display math block
    return pandoc.RawBlock('typst', wrap_math(para.content[1].text))
  end
  
  return nil
end

-- Return the filter
return {
  { Math = Math },
  { Para = Para }
}